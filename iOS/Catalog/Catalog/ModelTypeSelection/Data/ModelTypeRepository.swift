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

  func fetch(carId: Int) async throws -> [ModelTypeOption] {
    let dto: ModelTypeResponseDTO = try await modelTypeRequestManager.perform(ModelTypeRequest.fetchOptions(carId: carId))
    return []
  }

  func calculateFuelAndDisplacement(with powerTrainId: Int, andwith driverTrainId: Int) async throws -> ResultOfCalculationOfFuelAndDisplacement {
    return .mock()
  }

}

final class MockModelTypeRepository: ModelTypeRepositoryProtocol {

  func calculateFuelAndDisplacement(with powerTrainId: Int, andwith driverTrainId: Int) async throws -> ResultOfCalculationOfFuelAndDisplacement {
    return ResultOfCalculationOfFuelAndDisplacement.init(displacement: 2199, fuelEfficiency: 12)
  }

  func fetch(carId: Int) async throws -> [ModelTypeOption] {

    let manager = RequestManager(apiManager: MockAPIManager())
    guard let data = JSONLoader.load(with: "ModelType") else {
        return []
    }
    let url = URL(string: "https://api.cartalog.com/car/\(carId)/model-type")!
    MockURLProtocol.mockURLs = [
      url: (nil, data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil))
    ]

    return [
      ModelTypeOption(title: "파워트레인", options: [
        OptionState(id: .init(), isSelected: true, frequency: Int.random(in: 0...90), title: "디젤2.2", price: CLNumber(0)),
        OptionState(id: .init(), isSelected: false, frequency: 38, title: "가솔린3.8", price: CLNumber(280000))
      ], optionsInDetail: []),

      ModelTypeOption(title: "바디타입", options: [
        .init(id: .init(),
              isSelected: true,
              frequency: Int.random(in: 0..<100),
              title: "7인승",
              price: CLNumber(0)),
        .init(id: .init(),
              isSelected: false,
              frequency: .random(in: 0..<100),
              title: "10인승",
              price: .init(280000))
      ], optionsInDetail: []),

      ModelTypeOption(title: "구동방식", options: [
        .init(id: .init(),
              isSelected: true,
              frequency: .random(in: 0..<100),
              title: "2WD",
              price: .init(0)),
        .init(id: .init(),
              isSelected: false,
              frequency: .random(in: 0..<100),
              title: "4WD",
              price: .init(237000))
      ], optionsInDetail: [])

    ]

  }

}
