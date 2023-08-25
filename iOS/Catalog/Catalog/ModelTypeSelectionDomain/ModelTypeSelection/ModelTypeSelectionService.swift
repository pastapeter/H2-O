//
//  ModelTypeSelectionService.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/24.
//

import Foundation


protocol ModeltypeSelectionService {
  
  func updatePowertrain(option: ModelTypeOption)
  func updateBodytype(option: ModelTypeOption)
  func updateDrivetrain(option: ModelTypeOption)
  func powertrainName() -> String
  func drivetrainName() -> String
  
}

extension Quotation: ModeltypeSelectionService {
  func powertrainName() -> String {
    quotation.powertrain.name
  }
  
  func drivetrainName() -> String {
    quotation.drivetrain.name
  }
  
  func updatePowertrain(option: ModelTypeOption) {
    quotation.powertrain = option
  }
  
  func updateBodytype(option: ModelTypeOption) {
    quotation.bodytype = option
  }
  
  func updateDrivetrain(option: ModelTypeOption) {
    quotation.drivetrain = option
  }

}
