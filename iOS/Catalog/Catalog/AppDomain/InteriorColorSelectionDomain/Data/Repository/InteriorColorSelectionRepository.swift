//
//  InteriorColorSelectionRepository.swift
//  Catalog
//
//  Created by Jung peter on 8/16/23.
//

import Foundation

final class InteriorColorSelectionRepository: InteriorColorSelectionRepositoryProtocol {

  private var requestManager: RequestManagerProtocol

  init(requestManager: RequestManagerProtocol) {
    self.requestManager = requestManager
  }

  func fetch(with trimId: Int) async throws -> [InteriorColor] {
    let dto: [InteriorColorResponseDTO] = try await requestManager.perform(InteriorColorRequest.fetch(trimId: trimId))
    return dto.compactMap { dto in
      do {
        return try dto.toDomain()
      } catch let e {
        Log.debug(message: "🚨 \(e.localizedDescription)")
       return nil
      }
    }
  }

}
