//
//  MockExternalColorRepository.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import Foundation

final class MockExternalRepository: ExternalColorRepositoryProtocol {

  func fetch(with trimId: Int) async throws -> [ExternalColor] {
    return [
      ExternalColor(id: 123, name: "어비스 블랙펄", choiceRatio: CLNumber(38), price: CLNumber(0), hexCode: "#1c2d3e"),
      ExternalColor(id: 456, name: "그라파이트 그레이 메타릭", choiceRatio: CLNumber(20), price: CLNumber(0), hexCode: "2c3e7f")
    ]
  }

}
