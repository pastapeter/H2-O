//
//  ModelTypeSelectionContainerIntent.swift
//  Catalog
//
//  Created by Jung peter on 8/14/23.
//

import Foundation
import Combine

protocol ModelTypeSelectionContainerIntentType {

  var state: ModelTypeSelectionContainerModel.State { get }

  func send(action: ModelTypeSelectionContainerModel.ViewAction)

  func send(action: ModelTypeSelectionContainerModel.ViewAction, viewEffect: (() -> Void)?)

}

final class ModelTypeSelectionContainerIntent: ObservableObject {

  init(initialState: State) {
    state = initialState
  }

  typealias State = ModelTypeSelectionContainerModel.State

  typealias ViewAction = ModelTypeSelectionContainerModel.ViewAction

  @Published var state: State = .mock()

  var cancellable: Set<AnyCancellable> = []
}

extension ModelTypeSelectionContainerIntent: ModelTypeSelectionContainerIntentType, IntentType {

  func mutate(action: ModelTypeSelectionContainerModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
    case .onAppear:
      return
    case .calculateFuelEfficiency:
      return
    }
  }

}
