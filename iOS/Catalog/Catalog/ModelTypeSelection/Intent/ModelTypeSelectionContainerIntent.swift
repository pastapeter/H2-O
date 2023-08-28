//
//  ModelTypeSelectionContainerIntent.swift
//  Catalog
//
//  Created by Jung peter on 8/14/23.
//

import Foundation
import Combine

protocol ModelTypeSelectionContainerIntentType: AnyObject {

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
  
  private var powerTrainOptionId: Int = 1
  private var driveTrainOptionId: Int = 1
  
}

extension ModelTypeSelectionContainerIntent: ModelTypeSelectionContainerIntentType, IntentType {

  func mutate(action: ModelTypeSelectionContainerModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
    case .onAppear:
      Task {
        let options = try await repository.fetch(carId: state.selectedTrimId)
        send(action: .modelTypeOptions(options: options))
        send(action: .calculateFuelEfficiency(typeId: 0, selectedOptionId: self.powerTrainOptionId))
      }
    case .calculateFuelEfficiency(let typeID, let selectedOptionId):
      Task {
        await calculateFuelEfficiency(typeID:typeID, selectedOptionId: selectedOptionId)
      }
    case .modelTypeOptions(let options):
      state.modelTypeStateArray = convertToModelTypeModelState(from: options)
    }
  }

}

// MARK: - Private Function

extension ModelTypeSelectionContainerIntent {
  
  private func calculateFuelEfficiency(typeID: Int, selectedOptionId: Int) async {
  
      do {
        
        let powerTrainID = ModelTypeSelectionContainerModel.ModelTypeID.powerTrain.rawValue
        let driveTrainID = ModelTypeSelectionContainerModel.ModelTypeID.driveTrain.rawValue
        
        if typeID == powerTrainID {
          self.powerTrainOptionId = selectedOptionId
        } else if typeID == driveTrainID {
          self.driveTrainOptionId = selectedOptionId
        }
        
        let powerTrainTitle = state.modelTypeStateArray[powerTrainID]
          .optionStates[self.powerTrainOptionId - 1]
          .title
        
        let driveTrainTitle = state.modelTypeStateArray[driveTrainID]
          .optionStates[self.driveTrainOptionId - 1]
          .title
      
        let result = try await self.repository
          .calculateFuelAndDisplacement(with: self.powerTrainOptionId,
                                        andwith: self.driveTrainOptionId)
        
        state.fuelEfficiencyAverageState = .init(engine: powerTrainTitle,
                                                 wheelType: driveTrainTitle,
                                                 displacement: result.displacement,
                                                 fuelEfficiency: result.fuelEfficiency)
        
      } catch (let e) {
        print(e)
      }
    
  }

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
