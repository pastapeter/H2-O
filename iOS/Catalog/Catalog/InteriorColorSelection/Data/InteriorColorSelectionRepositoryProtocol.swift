//
//  InteriorColorSelectionRepository.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import Foundation

protocol InteriorColorSelectionRepositoryProtocol {
  func fetch(with trimId: Int) async throws -> [InteriorColor]
}

final class MockInteriorColorSelectionRepository: InteriorColorSelectionRepositoryProtocol {

  init() {

  }

  func fetch(with trimId: Int) async throws -> [InteriorColor] {

    return [
      .init(id: 123,
            name: "퀄팅천연(블랙)",
            choiceRatio: .init(38),
            price: .init(0),
            fabricImageURL: nil,
            bannerImageURL: nil),
      .init(id: 456,
            name: "쿨그레이",
            choiceRatio: .init(22),
            price: .init(0),
            fabricImageURL: nil,
            bannerImageURL: nil)
    ]

  }

}
