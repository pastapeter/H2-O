//
//  OptionSelectionIntent.swift
//  Catalog
//
//  Created by Jung peter on 8/17/23.
//

import Foundation
import Combine

protocol OptionSelectionIntentType {

  var state: OptionSelectionModel.State { get }

  func send(action: OptionSelectionModel.ViewAction)

  func send(action: OptionSelectionModel.ViewAction, viewEffect: (() -> Void)?)

}

final class OptionSelectionIntent: ObservableObject {

  init(initialState: State) {
    state = initialState
  }

  typealias State = OptionSelectionModel.State
  typealias ViewAction = OptionSelectionModel.ViewAction

  @Published var state: State

  var cancellable: Set<AnyCancellable> = []

}

extension OptionSelectionIntent: OptionSelectionIntentType, IntentType {

  func mutate(action: OptionSelectionModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
    case .onTapTab(let index):
      state.currentPage = index
    }
  }

}
