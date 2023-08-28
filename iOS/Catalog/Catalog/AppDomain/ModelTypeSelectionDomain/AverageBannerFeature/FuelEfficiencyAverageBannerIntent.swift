//
//  FuelEfficiencyAverageBannerIntent.swift
//  Catalog
//
//  Created by Jung peter on 8/28/23.
//

import Foundation
import Combine

protocol FuelEfficiencyAverageBannerIntentType {
  
  var viewState: FuelEfficiencyAverageBannerModel.ViewState { get }
  
  var state: FuelEfficiencyAverageBannerModel.State { get }
  
  func send(action: FuelEfficiencyAverageBannerModel.ViewAction)
  
  func send(action: FuelEfficiencyAverageBannerModel.ViewAction, viewEffect: (() -> Void)?)
  
}

final class FuelEfficiencyAverageBannerIntent: ObservableObject {
  
  init(initialState: FuelEfficiencyAverageBannerModel.State,
       repository: ModelTypeRepositoryProtocol,
       quotation: ModeltypeSelectionService) {
    state = initialState
    self.repository = repository
    self.quotation = quotation
    viewState = .init(engine: state.engine, wheelType: state.wheelType, displacement: state.displacement, fuelEfficiency: state.fuelEfficiency)
  }
  
  typealias ViewState = FuelEfficiencyAverageBannerModel.ViewState
  typealias ViewAction = FuelEfficiencyAverageBannerModel.ViewAction
  typealias State = FuelEfficiencyAverageBannerModel.State
  
  @Published var viewState: FuelEfficiencyAverageBannerModel.ViewState
  var state: FuelEfficiencyAverageBannerModel.State
  
  var cancellable: Set<AnyCancellable> = []
  private var quotation: ModeltypeSelectionService
  private var repository: ModelTypeRepositoryProtocol
  private var powerTrainOptionId: Int = 1
  private var driveTrainOptionId: Int = 1
  
}

extension FuelEfficiencyAverageBannerIntent: FuelEfficiencyAverageBannerIntentType, IntentType {
  
  func mutate(action: FuelEfficiencyAverageBannerModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
    case .calculateFuelEfficiency(let typeId, let selectedOptionId):
      Task {
        await calculateFuelEfficiency(typeID: typeId, selectedOptionId: selectedOptionId)
      }
    }
  }
  
  
}

extension FuelEfficiencyAverageBannerIntent {
  
  private func calculateFuelEfficiency(typeID: Int, selectedOptionId: Int) async {
    
    do {
      
      let powerTrainID = ModelTypeSelectionModel.ModelTypeID.powerTrain.rawValue
      let driveTrainID = ModelTypeSelectionModel.ModelTypeID.driveTrain.rawValue
      
      if typeID == powerTrainID {
        self.powerTrainOptionId = selectedOptionId
      } else if typeID == driveTrainID {
        self.driveTrainOptionId = selectedOptionId
      }
      
      let powerTrainTitle = quotation.powertrainName()
      let driveTrainTitle = quotation.drivetrainName()
      
      let result = try await self.repository
        .calculateFuelAndDisplacement(with: self.driveTrainOptionId,
                                      andwith: self.powerTrainOptionId)
      
      viewState.displacement = result.displacement
      viewState.fuelEfficiency = result.fuelEfficiency
      viewState.wheelType = driveTrainTitle
      viewState.engine = powerTrainTitle
      
    } catch (let e) {
      print(e.localizedDescription)
    }
    
  }
  
}
