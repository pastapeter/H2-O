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

}

final class OptionCardScrollIntent: ObservableObject {

  init(initialState: State, repository: OptionSelectionRepositoryProtocol) {
    state = initialState
    self.repository = repository
  }

  typealias State = OptionCardScrollModel.State
  typealias ViewAction = OptionCardScrollModel.ViewAction

  @Published var state: State

  var cancellable: Set<AnyCancellable> = []
  private var repository: OptionSelectionRepositoryProtocol

}

extension OptionCardScrollIntent: OptionCardScrollIntentType, IntentType {

  func mutate(action: OptionCardScrollModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
    case .onAppear:
      send(action: .fetchCardState(from: state.startIndex, to: state.endIndex))
    case .onTapFilterButton(let index):
      state.filterState.selectedFilterId = index
    case .fetchCardState(let from, let to):
      fetchCardState(from: from, to: to)
    case .onTapOption(let id):
      state.selectedOptionId = id
    case .cardStates(let states):
      state.cardStates = states
    }
  }
  
  
  private func fetchCardState(from: Int, to: Int) {
    
    Task {
      do {
        if state.isExtraOptionTab {
          let states = try await repository.fetchExtraOption(from: from, to: to)
          
          let carStateArray = states.map {
            return OptionCardModel.State(id: $0.id, hashTags: $0.hashTags, name: $0.name, choiceRatio: $0.choiceRatio, imageURL: $0.image, price: $0.price, containsHmgData: $0.containsHmgData, category: $0.category)
          }
          

          send(action: .cardStates(states: carStateArray))
        
        } else {
          let states = try await repository.fetchDefaultOption(from: from, to: to)
          let carStateArray = states.map {
            return OptionCardModel.State(id: $0.id, hashTags: $0.hashTags, name: $0.name, imageURL: $0.image, containsHmgData: $0.containsHmgData, category: $0.category)
          }
          send(action: .cardStates(states: carStateArray))
        }
      } catch(let e) {
        state.error = e
      }
    }
  }

}
