//
//  OptionCardScrollIntent.swift
//  Catalog
//
//  Created by Jung peter on 8/17/23.
//

import Foundation
import Combine

protocol OptionCardScrollIntentType: AnyObject {

  var state: OptionCardScrollModel.State { get }

  func send(action: OptionCardScrollModel.ViewAction)

  func send(action: OptionCardScrollModel.ViewAction, viewEffect: (() -> Void)?)
  
  var repository: OptionSelectionRepositoryProtocol { get }

}

final class OptionCardScrollIntent: ObservableObject {

  init(initialState: State, repository: OptionSelectionRepositoryProtocol, parent: OptionSelectionCollectable?) {
    state = initialState
    self.repository = repository
    self.parent = parent
  }

  typealias State = OptionCardScrollModel.State
  typealias ViewAction = OptionCardScrollModel.ViewAction

  @Published var state: State

  var cancellable: Set<AnyCancellable> = []
  private(set) var repository: OptionSelectionRepositoryProtocol
  private var totalCardState: [OptionCardModel.State] = []
  private weak var parent: OptionSelectionCollectable?

}

extension OptionCardScrollIntent: OptionCardScrollIntentType, IntentType {

  func mutate(action: OptionCardScrollModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
    case .onAppear:
      onAppear()
    case .onTapFilterButton(let index):
      state.filterState.selectedFilterId = index
      filterOptions(with: state.filterState.filters[index])
    case .fetchCardState(let from, let to):
      fetchCardState(from: from, to: to)
      case .onTapOption(let option):
      if state.isExtraOptionTab {
        parent?.selectedOption(with: option)
      }
    case .cardStates(let states):
      state.cardStates = states
    }
  }
  
}

// MARK: - Private Function

extension OptionCardScrollIntent {
  
  private func onAppear() {
    if totalCardState.isEmpty {
      if state.isExtraOptionTab {
        fetchAllExtraOptions()
      } else {
        fetchAllDefaultOptions()
      }
    } else {
      filterOptions(with: state.filterState.filters[state.filterState.selectedFilterId])
    }
  }
  
  private func filterOptions(with category: OptionCategory) {
    if category != .total {
      state.cardStates = self.totalCardState.filter { $0.category == category }
    } else {
      state.cardStates = self.totalCardState
    }
  }
  
  private func fetchAllDefaultOptions() {
    
    Task {
      do {
        let states: [DefaultOption] = try await repository.fetchAllOptions()
        let defaultCellInfos = states.map { return OptionCardModel.State(id: $0.id, hashTags: $0.hashTags,
                                                                         name: $0.name,
                                                                         imageURL: $0.image, containsHmgData: $0.containsHmgData,
                                                                         category: $0.category, defaultOptionDetail: .mock(), packageOption: .mock()) }
        
        self.totalCardState = defaultCellInfos
        send(action: .cardStates(states: totalCardState))
      } catch (let e) {
        print(e)
        state.error = e
      }
    }
    
  }
  
  private func fetchAllExtraOptions() {
    
    Task {
      do {
        let states: [ExtraOption] = try await repository.fetchAllOptions()
        let extraCellInfos = states.map { return OptionCardModel.State(id: $0.id, isPackage: $0.isPackage,
                                hashTags: $0.hashTags,
                                name: $0.name,
                                choiceRatio: $0.choiceRatio,
                                imageURL: $0.image,
                                price: $0.price,
                                containsHmgData: $0.containsHmgData,
                                category: $0.category) }
        self.totalCardState = extraCellInfos
        send(action: .cardStates(states: totalCardState))
      } catch (let e) {
        print(e)
        state.error = e
      }
    }
    
  }
  
  private func fetchCardState(from: Int, to: Int) {
    
    Task {
      do {
        if state.isExtraOptionTab {
          let states : [ExtraOption] = try await repository.fetchOption(from: from, to: to)
          
          let carStateArray = states.map {
            return OptionCardModel.State(id: $0.id, isPackage: $0.isPackage, hashTags: $0.hashTags, name: $0.name, choiceRatio: $0.choiceRatio, imageURL: $0.image, price: $0.price, containsHmgData: $0.containsHmgData, category: $0.category, defaultOptionDetail: .mock(), packageOption: .mock())
          }
          
          send(action: .cardStates(states: carStateArray))
        
        } else {
          let states: [DefaultOption] = try await repository.fetchOption(from: from, to: to)
          let carStateArray = states.map {
            return OptionCardModel.State(id: $0.id,
                                         hashTags: $0.hashTags,
                                         name: $0.name,
                                         imageURL: $0.image,
                                         containsHmgData: $0.containsHmgData,
                                         category: $0.category)
          }
          send(action: .cardStates(states: carStateArray))
        }
      } catch(let e) {
        state.error = e
      }
    }
  }
  
}
