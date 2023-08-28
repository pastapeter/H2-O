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
  
}

extension FuelEfficiencyAverageBannerIntent: FuelEfficiencyAverageBannerIntentType, IntentType {
  
  func mutate(action: FuelEfficiencyAverageBannerModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
    case .calculateFuelEfficiency:
      quotation.powertrainPublisher.combineLatest(quotation.driveTrainPublisher)
        .sink { [weak self] powertrain, driveTrain in
          self?.calculateFuelEfficiency(powerTrain: powertrain, drivetrain: driveTrain)
        }.store(in: &cancellable)
    }
  }
  
  
}

extension FuelEfficiencyAverageBannerIntent {
  
  private func calculateFuelEfficiency(powerTrain: ModelTypeOption, drivetrain: ModelTypeOption) {
    Task {
      do {
        
        let powerTrainTitle = quotation.powertrain().name
        let driveTrainTitle = quotation.drivetrain().name
        
        let result = try await self.repository
          .calculateFuelAndDisplacement(with: powerTrain.id, andwith: drivetrain.id)
        
        viewState.displacement = result.displacement
        viewState.fuelEfficiency = result.fuelEfficiency
        viewState.wheelType = driveTrainTitle
        viewState.engine = powerTrainTitle
        
      } catch (let e) {
        print(e.localizedDescription)
      }
    }
  }
  
}
