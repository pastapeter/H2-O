//
//  ExteriorColorRepository.swift
//  Catalog
//
//  Created by Jung peter on 8/16/23.
//

import Foundation

final class ExteriorColorRepository: ExteriorColorRepositoryProtocol {

  private var requestManager: RequestManagerProtocol

  init(requestManager: RequestManagerProtocol) {
    self.requestManager = requestManager
  }

  func fetch(with trimId: Int) async throws -> [ExternalColor] {
    let dto: [ExteriorColorResponseDTO] = try await requestManager.perform(ExteriorColorRequest.fetch(trimId: trimId))
    print(dto)
    return []
  }

}
