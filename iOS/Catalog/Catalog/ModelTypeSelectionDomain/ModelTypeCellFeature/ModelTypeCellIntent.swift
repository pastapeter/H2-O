//
//  ModelTypeIntent.swift
//  Catalog
//
//  Created by Jung peter on 8/13/23.
//

import Foundation
import Combine

protocol ModelTypeCellIntentType {
  
  var viewState: ModelTypeCellModel.State { get }
  
  func send(action: ModelTypeCellModel.ViewAction, viewEffect: (() -> Void)?)
  
  func send(action: ModelTypeCellModel.ViewAction)
  
}

final class ModelTypeCellIntent: ObservableObject {
  
  init(initialState: ViewState, parent: ModelTypeSelectionIntentType? = nil) {
    viewState = initialState
    self.parent = parent
  }
  
  typealias ViewState = ModelTypeCellModel.State
  
  typealias ViewAction = ModelTypeCellModel.ViewAction
  
  @Published var viewState: ViewState = .init()
  
  var cancellable: Set<AnyCancellable> = []
  
  weak var parent: ModelTypeSelectionIntentType?
  
}

extension ModelTypeCellIntent: ModelTypeCellIntentType, IntentType {
  
  func mutate(action: ModelTypeCellModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
      case .onTapDetailButton(let isPresenting):
        viewState.isModalPresenting = isPresenting
      case .onTapOptions(let id):
        toggleAll(id: id)
        viewState.selectedId = id
        sendOptionToQuotationService(of: id)
    }
  }
}

extension ModelTypeCellIntent {
  private func selectedModelTypeOption(of id: Int) -> ModelTypeOption? {
    viewState.modelTypeDetailState.first { $0.id == id }?.convertModelTypeDetailStateToModelTypeOption()
  }
  
  private func sendOptionToQuotationService(of id: Int) {
    if viewState.title == "파워트레인" {
      parent?.send(action: .calculateFuelEfficiency(typeId: 0, selectedOptionId: viewState.selectedId))
      if let selectedOption = selectedModelTypeOption(of: id) {
        parent?.send(action: .powertrainSelected(option: selectedOption))
      }
    }
    else if viewState.title == "구동방식" {
      parent?.send(action: .calculateFuelEfficiency(typeId: 2, selectedOptionId: viewState.selectedId))
      if let selectedOption = selectedModelTypeOption(of: id) {
        parent?.send(action: .drivetrainSelected(option: selectedOption))
      }
    } else {
      if let selectedOption = selectedModelTypeOption(of: id) {
        parent?.send(action: .bodytypeSelected(option: selectedOption))
      }
    }
  }
  
}

extension ModelTypeCellIntent {
  
  private func toggleAll(id: Int) {
    for i in 0..<viewState.optionStates.count {
      if viewState.optionStates[i].id == id {
        viewState.optionStates[i].isSelected = true
      } else {
        viewState.optionStates[i].isSelected = false
      }
    }
  }
  
}
