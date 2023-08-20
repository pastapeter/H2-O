//
//  MockExternalColorRepository.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import Foundation

final class MockExternalRepository: ExteriorColorRepositoryProtocol {

  func fetch(with trimId: Int) async throws -> [ExteriorColor] {
    return [
      ExteriorColor(id: 123,
                    name: "어비스 블랙펄",
                    choiceRatio: CLNumber(38),
                    price: CLNumber(0),
                    hexCode: "#1c2d3e",
                    exteriorImages: []),
      ExteriorColor(id: 456,
                    name: "그라파이트 그레이 메타릭",
                    choiceRatio: CLNumber(20),
                    price: CLNumber(0),
                    hexCode: "2c3e7f",
                    exteriorImages: []),
      ExteriorColor(id: 789,
                    name: "그라파이트 그레이 메타릭2",
                    choiceRatio: CLNumber(20),
                    price: CLNumber(0),
                    hexCode: "2c3e00",
                    exteriorImages: [])
    ]
  }

}
