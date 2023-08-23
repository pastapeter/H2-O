//
//  ModelTypeSelectionContainerIntent.swift
//  Catalog
//
//  Created by Jung peter on 8/14/23.
//

import Foundation
import Combine

protocol ModelTypeSelectionIntentType: AnyObject {
  
  var state: ModelTypeSelectionModel.State { get }
  
  func send(action: ModelTypeSelectionModel.ViewAction)
  
  func send(action: ModelTypeSelectionModel.ViewAction, viewEffect: (() -> Void)?)
  
}

final class ModelTypeSelectionIntent: ObservableObject {
  
  init(initialState: State, repository: ModelTypeRepositoryProtocol) {
    state = initialState
    self.repository = repository
  }
  
  private var repository: ModelTypeRepositoryProtocol
  
  typealias State = ModelTypeSelectionModel.State
  
  typealias ViewAction = ModelTypeSelectionModel.ViewAction
  
  @Published var state: State
  
  var cancellable: Set<AnyCancellable> = []
  private var quotation = Quotation.shared
  private var powerTrainOptionId: Int = 1
  private var driveTrainOptionId: Int = 1
  
}

extension ModelTypeSelectionIntent: ModelTypeSelectionIntentType, IntentType {
  
  func mutate(action: ModelTypeSelectionModel.ViewAction, viewEffect: (() -> Void)?) {
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
        
      case .powertrainSelected(option: let option):
        Quotation.shared.send(action: .isPowertrainChanged(powertrain: option))
      case .bodytypeSelected(option: let option):
        Quotation.shared.send(action: .isBodyTypeChanged(bodytype: option))
      case .drivetrainSelected(option: let option):
        Quotation.shared.send(action: .isDrivetrainChanged(drivetrain: option))
    }
  }
}

// MARK: - Private Function

extension ModelTypeSelectionIntent {
  
  private func calculateFuelEfficiency(typeID: Int, selectedOptionId: Int) async {
    
    do {
      
      let powerTrainID = ModelTypeSelectionModel.ModelTypeID.powerTrain.rawValue
      let driveTrainID = ModelTypeSelectionModel.ModelTypeID.driveTrain.rawValue
      
      if typeID == powerTrainID {
        self.powerTrainOptionId = selectedOptionId
      } else if typeID == driveTrainID {
        self.driveTrainOptionId = selectedOptionId
      }
      
      let powerTrainTitle = quotation.state.quotation?.powertrain.name ?? ""
      let driveTrainTitle = quotation.state.quotation?.drivetrain.name ?? ""
      
      
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
  
  private func convertToModelTypeModelState(from options: [ModelType]) -> [ModelTypeCellModel.State] {
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
    
    var content = options.map {
      ModelTypeDetailState.init(id: $0.id, title: $0.name, description: $0.description, choiceRatio: $0.choiceRatio, imageURL: $0.imageURL, price: $0.price)
    }
    
    var engineOutputs: [Double] = []
    var torqueOutputs: [Double] = []
    
    options.enumerated().forEach { index, element in
      
      if let maxOutput = element.maxOuputFromEngine,
         let maxTorque = element.maxTorqueFromEngine {
        
        content[index].hmgData = HMGModelTypeState(engineOutput: maxOutput, torque: maxTorque, enginePercent: 0.0, torquePercent: 0.0)
        
        engineOutputs.append(maxOutput.output / Double(maxOutput.maxRPM))
        torqueOutputs.append(maxTorque.torque / Double(maxOutput.maxRPM))
        
      }
      
    }
    
    if engineOutputs.count == 2 && torqueOutputs.count == 2 {
      
      if engineOutputs[0] > engineOutputs[1] {
        content[0].hmgData?.enginePercent = 1
        content[1].hmgData?.enginePercent = engineOutputs[1] / engineOutputs[0]
      } else {
        content[0].hmgData?.enginePercent = engineOutputs[0] / engineOutputs[1]
        content[1].hmgData?.enginePercent = 1
      }
      
      if torqueOutputs[0] > torqueOutputs[1] {
        content[0].hmgData?.torquePercent = 1
        content[1].hmgData?.torquePercent = torqueOutputs[1] / torqueOutputs[0]
      } else {
        content[0].hmgData?.torquePercent = torqueOutputs[0] / torqueOutputs[1]
        content[1].hmgData?.torquePercent = 1
      }
      
    }
    
    
    
    return content
    
  }
  
}
