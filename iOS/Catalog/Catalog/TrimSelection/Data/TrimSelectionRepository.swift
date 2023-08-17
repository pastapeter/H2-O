//
//  TrimSelectionRepository.swift
//  Catalog
//
//  Created by Jung peter on 8/9/23.
//

import Foundation

protocol TrimSelectionRepositoryProtocol {
  func fetchTrims(in vehicleId: Int) async throws -> [Trim]
  func fetchDefaultOptionsByTrim(in trim: Trim) async throws -> CarQuotation
  func fetchMinMaxPriceByTrim(in trimId: Int) async throws -> (CLNumber, CLNumber)
}

final class TrimSelectionRepository: TrimSelectionRepositoryProtocol {

  private let trimSelectionRequestManager: RequestManagerProtocol = RequestManager(apiManager: TrimAPIManager())

  func fetchTrims(in carId: Int) async throws -> [Trim] {
    let dto: [TrimDTO] = try await trimSelectionRequestManager
      .perform(TrimSelectionRequest.fetchTrimList(carId: carId))
    return dto.compactMap { try? $0.toDomain() }
  }

  func fetchDefaultOptionsByTrim(in trim: Trim) async throws -> CarQuotation {
    let request = TrimSelectionRequest.fetchDefaultOption(trimId: trim.id)
    let dto: TrimDefaultOptionDTO = try await
    trimSelectionRequestManager.perform(request)
    return try dto.toDomain(trim: trim)
  }

  func fetchMinMaxPriceByTrim(in trimId: Int) async throws -> (CLNumber, CLNumber) {
    let request = TrimSelectionRequest.fetchTrimMaxMinPrice(trimId: trimId)
    let dto: MaxMinPriceDTO = try await trimSelectionRequestManager.perform(request)
    return try dto.toDomain()
  }
}
