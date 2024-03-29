//
//  ModelTypeSelectionContainerModel.swift
//  Catalog
//
//  Created by Jung peter on 8/14/23.
//

import Foundation

enum ModelTypeSelectionContainerModel {

  struct State: Equatable {

    var selectedTrimId: Int = 1
    var modelTypeStateArray: [ModelTypeModel.State] = []
    var fuelEfficiencyAverageState: FuelEfficiencyAverageBannerState = .mock()
  }

  enum ViewAction {
    case onAppear
    case modelTypeOptions(options: [ModelType])
    case calculateFuelEfficiency(typeId: Int, selectedOptionId: Int)
  }
  
  enum ModelTypeID: Int {
    case powerTrain = 0
    case bodyType
    case driveTrain
  }
  

}
