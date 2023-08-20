//
//  ModelTypeIntent.swift
//  Catalog
//
//  Created by Jung peter on 8/13/23.
//

import Foundation
import Combine

protocol ModelTypeCellIntentType {

  var state: ModelTypeCellModel.State { get }

  func send(action: ModelTypeCellModel.ViewAction, viewEffect: (() -> Void)?)

  func send(action: ModelTypeCellModel.ViewAction)

}

final class ModelTypeCellIntent: ObservableObject {

  init(initialState: State, parent: ModelTypeSelectionIntentType? = nil) {
    state = initialState
    self.parent = parent
  }

  typealias State = ModelTypeCellModel.State

  typealias ViewAction = ModelTypeCellModel.ViewAction

  @Published var state: State = .init()

  var cancellable: Set<AnyCancellable> = []
  
  weak var parent: ModelTypeSelectionIntentType?

}

extension ModelTypeCellIntent: ModelTypeCellIntentType, IntentType {

  func mutate(action: ModelTypeCellModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
    case .onTapDetailButton(let isPresenting):
      state.isModalPresenting = isPresenting
    case .onTapOptions(let id):
      
      toggleAll(id: id)
      state.selectedId = id
            
      if state.title == "파워트레인" {
        parent?.send(action: .calculateFuelEfficiency(typeId: 0, selectedOptionId: state.selectedId))
      } else if state.title == "구동방식" {
        parent?.send(action: .calculateFuelEfficiency(typeId: 2, selectedOptionId: state.selectedId))
      }
    }
  }

}

extension ModelTypeCellIntent {
  
  private func toggleAll(id: Int) {
    for i in 0..<state.optionStates.count {
      if state.optionStates[i].id == id {
        state.optionStates[i].isSelected = true
      } else {
        state.optionStates[i].isSelected = false
      }
    }
  }
  
}
