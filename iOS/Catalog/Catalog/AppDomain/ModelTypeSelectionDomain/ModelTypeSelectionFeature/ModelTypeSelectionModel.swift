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
    var modelTypeStateArray: [ModelTypeCellModel.State] = []
    var fuelEfficiencyAverageState: FuelEfficiencyAverageBannerModel.State = .mock()
  }
  
  struct State: Equatable {
    
  }

  enum ViewAction {
    case onAppear
    case getSelectedOption(title: String, option: ModelTypeOption)
    case modelTypeOptions(options: [ModelType])
    case powertrainSelected(option: ModelTypeOption)
    case bodytypeSelected(option: ModelTypeOption)
    case drivetrainSelected(option: ModelTypeOption)
  }
  
  enum ModelTypeID: Int {
    case powerTrain = 0
    case bodyType
    case driveTrain
  }
  

}
