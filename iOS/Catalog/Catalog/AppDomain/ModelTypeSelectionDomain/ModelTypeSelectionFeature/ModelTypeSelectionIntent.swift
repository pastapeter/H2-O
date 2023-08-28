//
//  ModelTypeSelectionContainerIntent.swift
//  Catalog
//
//  Created by Jung peter on 8/14/23.
//

import Foundation
import Combine

protocol ModelTypeSelectionIntentType {
  
  var viewState: ModelTypeSelectionModel.ViewState { get }
  
  var state: ModelTypeSelectionModel.State { get }
  
  func send(action: ModelTypeSelectionModel.ViewAction)
  
  func send(action: ModelTypeSelectionModel.ViewAction, viewEffect: (() -> Void)?)
  
  var repository: ModelTypeRepositoryProtocol { get }
  var quotation: ModeltypeSelectionService { get }
  
}

final class ModelTypeSelectionIntent: ObservableObject {
  
  init(initialState: ModelTypeSelectionModel.State, initialViewState: ViewState, repository: ModelTypeRepositoryProtocol, quotation: ModeltypeSelectionService) {
    state = initialState
    viewState = initialViewState
    self.repository = repository
    self.quotation = quotation

  }
  
  private(set) var repository: ModelTypeRepositoryProtocol
  
  typealias ViewState = ModelTypeSelectionModel.ViewState
  
  typealias ViewAction = ModelTypeSelectionModel.ViewAction
  
  @Published var viewState: ViewState
  var state: ModelTypeSelectionModel.State
  
  var cancellable: Set<AnyCancellable> = []
  private(set) var quotation: ModeltypeSelectionService
  
}

extension ModelTypeSelectionIntent: ModelTypeSelectionIntentType, IntentType {
 
  func mutate(action: ModelTypeSelectionModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
      case .onAppear:
        Task {
          let options = try await repository.fetch(carId: viewState.selectedTrimId)
          send(action: .modelTypeOptions(options: options))
        }
      case .modelTypeOptions(let options):
      viewState.modelTypeStateArray = convertToModelTypeModelState(from: options)
        
      case .powertrainSelected(option: let option):
        quotation.updatePowertrain(option: option)
        
      case .bodytypeSelected(option: let option):
        quotation.updateBodytype(option: option)
        
      case .drivetrainSelected(option: let option):
        quotation.updateDrivetrain(option: option)
       
    case .getSelectedOption(let title, let option):
      if title == "파워트레인" {
        send(action: .powertrainSelected(option: option))
      } else if title == "바디타입" {
        send(action: .bodytypeSelected(option: option))
      } else if title == "구동방식" {
        send(action: .drivetrainSelected(option: option))
      }
    }
  }
}

// MARK: - Private Function

extension ModelTypeSelectionIntent {
  
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
