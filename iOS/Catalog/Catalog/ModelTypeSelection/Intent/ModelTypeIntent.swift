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

  init(initialState: State, parent: ModelTypeSelectionContainerIntentType? = nil) {
    state = initialState
    self.parent = parent
  }

  typealias State = ModelTypeModel.State

  typealias ViewAction = ModelTypeModel.ViewAction

  @Published var state: State = .init()

  var cancellable: Set<AnyCancellable> = []
  
  weak var parent: ModelTypeSelectionContainerIntentType?

}

extension ModelTypeIntent: ModelTypeIntentType, IntentType {

  func mutate(action: ModelTypeModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
    case .onTapDetailButton(let isPresenting):
      state.isModalPresenting = isPresenting
    case .onTapOptions(let index, let id):
      
      toggleAll(index: index)
      state.selectedId = id
      state.selectedIndex = index
            
      if state.title == "파워트레인" {
        parent?.send(action: .calculateFuelEfficiency(typeId: 0, selectedOptionId: state.selectedId))
      } else if state.title == "구동방식" {
        parent?.send(action: .calculateFuelEfficiency(typeId: 2, selectedOptionId: state.selectedId))
      }
    }
  }

}

extension ModelTypeIntent {
  
  private func toggleAll(index: Int) {
    for i in 0..<state.optionStates.count {
      if i == index {
        state.optionStates[i].isSelected = true
      } else {
        state.optionStates[i].isSelected = false
      }
    }
  }
  
}
