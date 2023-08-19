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

  init(initialState: State, repository: ModelTypeRepositoryProtocol) {
    state = initialState
    self.repository = repository
  }

  private var repository: ModelTypeRepositoryProtocol

  typealias State = ModelTypeSelectionContainerModel.State

  typealias ViewAction = ModelTypeSelectionContainerModel.ViewAction

  @Published var state: State

  var cancellable: Set<AnyCancellable> = []
  
}

extension ModelTypeSelectionContainerIntent: ModelTypeSelectionContainerIntentType, IntentType {

  func mutate(action: ModelTypeSelectionContainerModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
    case .onAppear:
      Task {
        let options = try await repository.fetch(carId: state.selectedTrimId)
        send(action: .modelTypeOptions(options: options))
      }
    case .calculateFuelEfficiency:
      return
    case .modelTypeOptions(let options):
      state.modelTypeStateArray = convertToModelTypeModelState(from: options)
    }
  }

}

// MARK: - Private Function

extension ModelTypeSelectionContainerIntent {

  private func convertToModelTypeModelState(from options: [ModelType]) -> [ModelTypeModel.State] {
    options.map {
      .init(title: $0.title,
            imageURL: $0.options[0].imageURL,
            containsHMGData: $0.options[0].maxOuputFromEngine != nil,
            optionStates: convertToModelTypeOptionState(from: $0.options),
            modelTypeDetailState: convertToModelTypeDetail(from: $0.options)
      )
    }
     
  }
  
  private func convertToModelTypeOptionState(from options: [ModelTypeOption]) -> [ModelTypeOptionState] {
    
    var result = options.map {
      ModelTypeOptionState.init(id: $0.id, isSelected: false, choiceRatio: $0.choiceRatio, title: $0.name, price: $0.price)
    }
    
    if result.count > 0 {
      result[0].isSelected = true
    }
    
    return result
  }
  
  private func convertToModelTypeDetail(from options: [ModelTypeOption]) -> [ModelTypeDetailState] {
  
    let content = options.map {
      ModelTypeContent.init(title: $0.name, description: $0.description, choiceRatio: $0.choiceRatio, imageURL: $0.imageURL, price: $0.price)
    }
    
    let hmgData: [HMGModelTypeState?] = options.map {
      guard let maxOutput = $0.maxOuputFromEngine, let maxTorque = $0.maxTorqueFromEngine else { return nil }
      return HMGModelTypeState(EngineOutput: maxOutput, Torque: maxTorque)
    }
    
    return zip(content, hmgData).map {
      ModelTypeDetailState(content: $0.0, hmgData: $0.1)
    }
    
  }
  
}
