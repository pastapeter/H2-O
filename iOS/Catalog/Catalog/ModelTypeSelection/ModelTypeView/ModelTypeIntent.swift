//
//  ModelTypeIntent.swift
//  Catalog
//
//  Created by Jung peter on 8/13/23.
//

import Foundation
import Combine

protocol ModelTypeIntentType {

  var state: ModelTypeModel.State { get }

  func send(action: ModelTypeModel.ViewAction, viewEffect: (() -> Void)?)

  func send(action: ModelTypeModel.ViewAction)

}

final class ModelTypeIntent: ObservableObject {

  init(initialState: State) {
    state = initialState
  }

  typealias State = ModelTypeModel.State

  typealias ViewAction = ModelTypeModel.ViewAction

  @Published var state: State = .init()

  var cancellable: Set<AnyCancellable> = []

}

extension ModelTypeIntent: ModelTypeIntentType, IntentType {

  func mutate(action: ModelTypeModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
    case .onTapDetailButton(let isPresenting):
      state.isModalPresenting = isPresenting
    case .onTapOptions(let index):
      for i in 0..<state.optionStates.count {
        if i == index {
          state.optionStates[i].isSelected = true
        } else {
          state.optionStates[i].isSelected = false
        }
      }

      state.selectedIndex = index
    }
  }

}
