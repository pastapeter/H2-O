//
//  ModelTypeRepository.swift
//  Catalog
//
//  Created by Jung peter on 8/14/23.
//

import Foundation

protocol ModelTypeRepositoryProtocol {

  func fetch(carId: Int) async throws -> [ModelTypeOption]

  func calculateFuelAndDisplacement(with powerTrainId: Int, andwith driverTrainId: Int)
  async throws -> ResultOfCalculationOfFuelAndDisplacement

}
