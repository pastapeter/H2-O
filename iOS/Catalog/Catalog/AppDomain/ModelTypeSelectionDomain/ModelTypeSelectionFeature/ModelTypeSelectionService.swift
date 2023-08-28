//
//  ModelTypeSelectionService.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/24.
//

import Foundation
import Combine


protocol ModeltypeSelectionService {
  
  func updatePowertrain(option: ModelTypeOption)
  func updateBodytype(option: ModelTypeOption)
  func updateDrivetrain(option: ModelTypeOption)
  func powertrain() -> ModelTypeOption
  func drivetrain() -> ModelTypeOption
  var powertrainPublisher: AnyPublisher<ModelTypeOption, Never> { get }
  var driveTrainPublisher: AnyPublisher<ModelTypeOption, Never> { get }
}

extension Quotation: ModeltypeSelectionService {
  
  var powertrainPublisher: AnyPublisher<ModelTypeOption, Never> {
    $quotation.map { $0.powertrain }.eraseToAnyPublisher()
  }
  
  var driveTrainPublisher: AnyPublisher<ModelTypeOption, Never> {
    $quotation.map { $0.drivetrain }.eraseToAnyPublisher()
  }
  
  
  
  func powertrain() -> ModelTypeOption {
    quotation.powertrain
  }
  
  func drivetrain() -> ModelTypeOption {
    quotation.drivetrain
  }
  
  func updatePowertrain(option: ModelTypeOption) {
    quotation.powertrain = option
    totalPrice = quotation.calculateTotalPrice()
  }
  
  func updateBodytype(option: ModelTypeOption) {
    quotation.bodytype = option
    totalPrice = quotation.calculateTotalPrice()
  }
  
  func updateDrivetrain(option: ModelTypeOption) {
    quotation.drivetrain = option
    totalPrice = quotation.calculateTotalPrice()
  }

}
