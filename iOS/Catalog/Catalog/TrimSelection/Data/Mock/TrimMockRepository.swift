//
//  TrimMockRepository.swift
//  Catalog
//
//  Created by Jung peter on 8/9/23.
//

import Foundation

final class TrimMockRepository: TrimSelectionRepositoryProtocol {

  func fetchTrims(in vehicleId: Int) async throws -> [Trim] {
    let manager = RequestManager(apiManager: MockAPIManager())
    guard let data = JSONLoader.load(with: "Trim") else { return [] }
    let url = URL(string: "https://api.catalog.com/vehicle/\(vehicleId)")!
    MockURLProtocol.mockURLs = [
      url: (nil, data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil))
    ]
    let dto: TrimResponseDTO = try await manager.perform(TrimSelectionRequest.fetchTrimList(vehicleId: vehicleId))
    print(dto)
    return dto.toDomain()
  }

}
