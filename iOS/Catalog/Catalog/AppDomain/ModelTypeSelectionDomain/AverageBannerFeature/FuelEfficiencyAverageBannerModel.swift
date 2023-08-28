//
//  FuelEfficiencyAverageBannerModel.swift
//  Catalog
//
//  Created by Jung peter on 8/28/23.
//

import Foundation

enum FuelEfficiencyAverageBannerModel {

  struct ViewState: Equatable {

    static func mock() -> Self {
      .init(engine: "디젤2.2", wheelType: "2WD", displacement: CLNumber(2199), fuelEfficiency: 12)
    }

    var engine: String
    var wheelType: String
    var displacement: CLNumber
    var fuelEfficiency: Double

  }
  
  struct State: Equatable {
    
    static func mock() -> Self {
      .init(engine: "디젤2.2", wheelType: "2WD", displacement: CLNumber(2199), fuelEfficiency: 12)
    }
    
    var engine: String
    var wheelType: String
    var displacement: CLNumber
    var fuelEfficiency: Double
    
  }
  
  enum ViewAction {
    case calculateFuelEfficiency
  }
  
}
