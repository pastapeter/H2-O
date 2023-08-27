//
//  OptionCardScrollIntent.swift
//  Catalog
//
//  Created by Jung peter on 8/17/23.
//

import Foundation
import Combine

protocol OptionCardScrollIntentType: AnyObject {

  var viewState: OptionCardScrollModel.ViewState { get }
  
  var state: OptionCardScrollModel.State { get }

  func send(action: OptionCardScrollModel.ViewAction)

  func send(action: OptionCardScrollModel.ViewAction, viewEffect: (() -> Void)?)
  
  var repository: OptionSelectionRepositoryProtocol { get }

}

final class OptionCardScrollIntent: ObservableObject {

  init(initialState: State, initialViewState: ViewState, repository: OptionSelectionRepositoryProtocol, parent: OptionSelectionCollectable?) {
    state = initialState
    viewState = initialViewState
    self.repository = repository
    self.parent = parent
  }

  typealias ViewState = OptionCardScrollModel.ViewState
  typealias ViewAction = OptionCardScrollModel.ViewAction
  typealias State = OptionCardScrollModel.State

  @Published var viewState: ViewState
  var state: State

  var cancellable: Set<AnyCancellable> = []
  private(set) var repository: OptionSelectionRepositoryProtocol
  private var totalCardState: [OptionCardModel.ViewState] = []
  private weak var parent: OptionSelectionCollectable?

}

extension OptionCardScrollIntent: OptionCardScrollIntentType, IntentType {

  func mutate(action: OptionCardScrollModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
    case .onAppear:
      onAppear()
    case .onTapFilterButton(let index):
      viewState.filterState.selectedFilterId = index
      filterOptions(with: viewState.filterState.filters[index])
    case .fetchCardState(let from, let to):
      fetchCardState(from: from, to: to)
      case .onTapOption(let option):
      if viewState.isExtraOptionTab {
        parent?.selectedOption(with: option)
      }
    case .cardStates(let states):
      viewState.cardStates = states
    }
  }
  
}

// MARK: - Private Function

extension OptionCardScrollIntent {
  
  private func onAppear() {
    if totalCardState.isEmpty {
      if viewState.isExtraOptionTab {
        fetchAllExtraOptions()
      } else {
        fetchAllDefaultOptions()
      }
    } else {
      filterOptions(with: viewState.filterState.filters[viewState.filterState.selectedFilterId])
    }
  }
  
  private func filterOptions(with category: OptionCategory) {
    if category != .total {
      viewState.cardStates = self.totalCardState.filter { $0.category == category }
    } else {
      viewState.cardStates = self.totalCardState
    }
  }
  
  private func fetchAllDefaultOptions() {
    
    Task {
      do {
        let states: [DefaultOption] = try await repository.fetchAllOptions()
        let defaultCellInfos = states.map { return OptionCardModel.ViewState(id: $0.id, hashTags: $0.hashTags,
                                                                         name: $0.name,
                                                                         imageURL: $0.image, containsHmgData: $0.containsHmgData,
                                                                         category: $0.category, defaultOptionDetail: .mock(), packageOption: .mock()) }
        
        self.totalCardState = defaultCellInfos
        send(action: .cardStates(states: totalCardState))
      } catch (let e) {
        print(e)
        viewState.error = e
      }
    }
    
  }
  
  private func fetchAllExtraOptions() {
    
    Task {
      do {
        let states: [ExtraOption] = try await repository.fetchAllOptions()
        let extraCellInfos = states.map { return OptionCardModel.ViewState(id: $0.id, isPackage: $0.isPackage,
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
        viewState.error = e
      }
    }
    
  }
  
  private func fetchCardState(from: Int, to: Int) {
    
    Task {
      do {
        if viewState.isExtraOptionTab {
          let states : [ExtraOption] = try await repository.fetchOption(from: from, to: to)
          
          let carStateArray = states.map {
            return OptionCardModel.ViewState(id: $0.id, isPackage: $0.isPackage, hashTags: $0.hashTags, name: $0.name, choiceRatio: $0.choiceRatio, imageURL: $0.image, price: $0.price, containsHmgData: $0.containsHmgData, category: $0.category, defaultOptionDetail: .mock(), packageOption: .mock())
          }
          
          send(action: .cardStates(states: carStateArray))
        
        } else {
          let states: [DefaultOption] = try await repository.fetchOption(from: from, to: to)
          let carStateArray = states.map {
            return OptionCardModel.ViewState(id: $0.id,
                                         hashTags: $0.hashTags,
                                         name: $0.name,
                                         imageURL: $0.image,
                                         containsHmgData: $0.containsHmgData,
                                         category: $0.category)
          }
          send(action: .cardStates(states: carStateArray))
        }
      } catch(let e) {
        viewState.error = e
      }
    }
  }
  
}
