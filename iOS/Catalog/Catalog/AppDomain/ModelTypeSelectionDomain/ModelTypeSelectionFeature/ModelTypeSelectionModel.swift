//
//  ModelTypeSelectionContainerModel.swift
//  Catalog
//
//  Created by Jung peter on 8/14/23.
//

import Foundation

enum ModelTypeSelectionModel {

  struct ViewState: Equatable {
    var selectedTrimId: Int = 1
    var fuelEfficiencyAverageState: FuelEfficiencyAverageBannerState = .mock()
  }
  
  struct State: Equatable {
    var modelTypeStateArray: [ModelTypeCellModel.State] = []
  }

  enum ViewAction {
    case onAppear
    case getSelectedOption(title: String, option: ModelTypeOption)
    case modelTypeOptions(options: [ModelType])
    case powertrainSelected(option: ModelTypeOption)
    case bodytypeSelected(option: ModelTypeOption)
    case drivetrainSelected(option: ModelTypeOption)
    case calculateFuelEfficiency(typeId: Int, selectedOptionId: Int)
  }
  
  enum ModelTypeID: Int {
    case powerTrain = 0
    case bodyType
    case driveTrain
  }
  

}
