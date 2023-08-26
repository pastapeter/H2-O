//
//  ModelTypeRepository.swift
//  Catalog
//
//  Created by Jung peter on 8/14/23.
//

import Foundation

final class ModelTypeRepository: ModelTypeRepositoryProtocol {

  private let modelTypeRequestManager: RequestManagerProtocol

  init(modelTypeRequestManager: RequestManagerProtocol) {
    self.modelTypeRequestManager = modelTypeRequestManager
  }

  func fetch(carId: Int) async throws -> [ModelType] {
    
    let dto: ModelTypeResponseDTO = try await modelTypeRequestManager.perform(ModelTypeRequest.fetchOptions(carId: carId))
    
    return dto.toDomain()
    
  }

  func calculateFuelAndDisplacement(with powerTrainId: Int, andwith driverTrainId: Int) async throws -> ResultOfCalculationOfFuelAndDisplacement {
    
    let dto: TechnicalSpecResponseDTO = try await modelTypeRequestManager.perform(ModelTypeRequest.calculateFuelAndDisplacement(powertrainId: powerTrainId, drivetrainId: driverTrainId))
    
    return try dto.toDomain()
    
  }

}

final class MockModelTypeRepository: ModelTypeRepositoryProtocol {

  func calculateFuelAndDisplacement(with powerTrainId: Int, andwith driverTrainId: Int) async throws -> ResultOfCalculationOfFuelAndDisplacement {
    return ResultOfCalculationOfFuelAndDisplacement.init(displacement: CLNumber(2199), fuelEfficiency: 12.0)
  }

  func fetch(carId: Int) async throws -> [ModelType] {

    let manager = RequestManager(apiManager: MockAPIManager())
    guard let data = JSONLoader.load(with: "ModelType") else {
        return []
    }
    let url = URL(string: "https://api.cartalog.com/car/\(carId)/model-type")!
    MockURLProtocol.mockURLs = [
      url: (nil, data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil))
    ]

    return []

  }

}
