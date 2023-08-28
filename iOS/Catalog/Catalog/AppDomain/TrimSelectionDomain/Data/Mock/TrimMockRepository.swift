//
//  TrimMockRepository.swift
//  Catalog
//
//  Created by Jung peter on 8/9/23.
//

import Foundation

final class TrimMockRepository: TrimSelectionRepositoryProtocol {

  func fetchTrims(of carId: Int) async throws -> [Trim] {
    let manager = RequestManager(apiManager: MockAPIManager())
    guard let data = JSONLoader.load(with: "Trim") else { return [] }
    let url = URL(string: "https://\(API.host):8080/carId/\(carId)")!
    MockURLProtocol.mockURLs = [
      url: (nil, data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil))
    ]
    let dto: TrimResponseDTO = try await manager.perform(TrimSelectionRequest.fetchTrimList(carId: carId))
      return dto.toDomain()
    }

  func fetchDefaultOptionsByTrim(of trim: Trim) async throws -> CarQuotation {
    let manager = RequestManager(apiManager: MockAPIManager())
    guard let data = JSONLoader.load(with: "TrimDefaultOption") else { throw MockError.JSONError }
    let url = URL(string: "https://\(API.host):8080/trim/\(trim.id)/default-options")!
    MockURLProtocol.mockURLs = [
      url: (nil, data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil))
    ]

    let dto: TrimDefaultOptionDTO = try await
    manager.perform(TrimSelectionRequest.fetchDefaultOption(trimId: trim.id))

    return try dto.toDomain(trim: trim)
  }

  func fetchMinMaxPriceByTrim(of trimId: Int) async throws -> (CLNumber, CLNumber) {
    let manager = RequestManager(apiManager: MockAPIManager())
    guard let data = JSONLoader.load(with: "TrimMaxMinPrice") else { throw MockError.JSONError }
    let url = URL(string: "https://\(API.host):8080/trim/\(trimId)/price-range")!
    MockURLProtocol.mockURLs = [
      url: (nil, data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil))
    ]
    let dto: MaxMinPriceDTO = try await
    manager.perform(TrimSelectionRequest.fetchTrimMaxMinPrice(trimId: trimId))
    return try dto.toDomain()
  }
}
