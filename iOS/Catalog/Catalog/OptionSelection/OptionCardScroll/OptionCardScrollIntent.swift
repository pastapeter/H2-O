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

  init(initialState: State) {
    state = initialState
  }

  typealias State = OptionCardScrollModel.State
  typealias ViewAction = OptionCardScrollModel.ViewAction

  @Published var state: State

  var cancellable: Set<AnyCancellable> = []

}

extension OptionCardScrollIntent: OptionCardScrollIntentType, IntentType {

  func mutate(action: OptionCardScrollModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
    case .onAppear:
      return
    case .onTapFilterButton(let index):
      state.filterState.selectedFilterId = index
    case .fetchCardState(_):
      return
    case .onTapOption(let id):
      state.selectedOptionId = id
    }
  }

}
