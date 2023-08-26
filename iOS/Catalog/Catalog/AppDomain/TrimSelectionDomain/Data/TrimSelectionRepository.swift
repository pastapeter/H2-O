//
//  TrimSelectionRepository.swift
//  Catalog
//
//  Created by Jung peter on 8/9/23.
//

import Foundation

protocol TrimSelectionRepositoryProtocol {
  func fetchTrims(of vehicleId: Int) async throws -> [Trim]
  func fetchDefaultOptionsByTrim(of trim: Trim) async throws -> CarQuotation
  func fetchMinMaxPriceByTrim(of trimId: Int) async throws -> (CLNumber, CLNumber)
}

final class TrimSelectionRepository: TrimSelectionRepositoryProtocol {

  private let trimSelectionRequestManager: RequestManagerProtocol = RequestManager(apiManager: TrimAPIManager())

  func fetchTrims(of carId: Int) async throws -> [Trim] {
    let dto: [TrimDTO] = try await trimSelectionRequestManager
      .perform(TrimSelectionRequest.fetchTrimList(carId: carId))
    return dto.compactMap { try? $0.toDomain() }
  }

  func fetchDefaultOptionsByTrim(of trim: Trim) async throws -> CarQuotation {
    let request = TrimSelectionRequest.fetchDefaultOption(trimId: trim.id)
    let dto: TrimDefaultOptionDTO = try await
    trimSelectionRequestManager.perform(request)
    return try dto.toDomain(trim: trim)
  }

  func fetchMinMaxPriceByTrim(of trimId: Int) async throws -> (CLNumber, CLNumber) {
    let request = TrimSelectionRequest.fetchTrimMaxMinPrice(trimId: trimId)
    let dto: MaxMinPriceDTO = try await trimSelectionRequestManager.perform(request)
    return try dto.toDomain()
  }
}
