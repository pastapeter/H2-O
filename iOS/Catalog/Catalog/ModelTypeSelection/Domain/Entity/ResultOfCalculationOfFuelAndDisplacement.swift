//
//  ResultOfCalculationOfFuelAndDisplacement.swift
//  Catalog
//
//  Created by Jung peter on 8/14/23.
//

import Foundation

struct ResultOfCalculationOfFuelAndDisplacement {

  static func mock() -> Self {
      return ResultOfCalculationOfFuelAndDisplacement(displacement: 2199, fuelEfficiency: 12)
  }

  var displacement: Int
  var fuelEfficiency: Int
}
