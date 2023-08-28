//
//  ModelTypeIntent.swift
//  Catalog
//
//  Created by Jung peter on 8/13/23.
//

import Foundation
import Combine

protocol ModelTypeCellIntentType {
  
  var viewState: ModelTypeCellModel.ViewState { get }
  
  var state: ModelTypeCellModel.State { get }
  
  func send(action: ModelTypeCellModel.ViewAction, viewEffect: (() -> Void)?)
  
  func send(action: ModelTypeCellModel.ViewAction)
  
}

final class ModelTypeCellIntent: ObservableObject {
  
  init(initialState: State) {
    state = initialState
    viewState = .init(title: state.title, imageURL: state.imageURL, selectedIndex: state.selectedIndex, selectedId: state.selectedId, isModalPresenting: state.isModalPresenting)
  }
  
  typealias ViewState = ModelTypeCellModel.ViewState
  typealias State = ModelTypeCellModel.State
  typealias ViewAction = ModelTypeCellModel.ViewAction
  
  @Published var viewState: ViewState = .init()
  {
    didSet {
      state = .init(title: viewState.title, imageURL: viewState.imageURL, containsHMGData: state.containsHMGData, optionStates: state.optionStates, selectedIndex: viewState.selectedIndex, selectedId: viewState.selectedId, modelTypeDetailState: state.modelTypeDetailState, isModalPresenting: viewState.isModalPresenting)
    }
  }
  
  var state: State
  
  var cancellable: Set<AnyCancellable> = []
  
}

extension ModelTypeCellIntent: ModelTypeCellIntentType, IntentType {
  
  func mutate(action: ModelTypeCellModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
    case .onTapDetailButton(let isPresenting):
      viewState.isModalPresenting = isPresenting
    case .onTapOptions(let id):
      state.selectedId = id
      toggleAll(id: id)
      if let selectedOption = selectedModelTypeOption(of: id) {
        state.selectedOption = selectedOption
      }
    }
  }
}

extension ModelTypeCellIntent {
  private func selectedModelTypeOption(of id: Int) -> ModelTypeOption? {
    state.modelTypeDetailState.first { $0.id == id }?.convertModelTypeDetailStateToModelTypeOption()
  }
  
//  private func sendOptionToQuotationService(of id: Int) {
//    if viewState.title == "파워트레인" {
//      parent?.send(action: .calculateFuelEfficiency(typeId: 0, selectedOptionId: viewState.selectedId))
//      if let selectedOption = selectedModelTypeOption(of: id) {
//        parent?.send(action: .powertrainSelected(option: selectedOption))
//      }
//    }
//    else if viewState.title == "구동방식" {
//      parent?.send(action: .calculateFuelEfficiency(typeId: 2, selectedOptionId: viewState.selectedId))
//      if let selectedOption = selectedModelTypeOption(of: id) {
//        parent?.send(action: .drivetrainSelected(option: selectedOption))
//      }
//    } else {
//      if let selectedOption = selectedModelTypeOption(of: id) {
//        parent?.send(action: .bodytypeSelected(option: selectedOption))
//      }
//    }
//  }
  
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
