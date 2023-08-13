//
//  ModelTypeRepository.swift
//  Catalog
//
//  Created by Jung peter on 8/14/23.
//

import Foundation

final class ModelTypeRepository: ModelTypeRepositoryProtocol {

  func fetch(vehicleId: Int) async throws -> [ModelTypeOption] {
    return []
  }

  func calculateFuelAndDisplacement(with powerTrainId: Int, andwith driverTrainId: Int) async throws -> ResultOfCalculationOfFuelAndDisplacement {
    return .mock()
  }

}
