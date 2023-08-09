//
//  TrimResponseDTO.swift
//  Catalog
//
//  Created by Jung peter on 8/9/23.
//

import Foundation

struct TrimResponseDTO: Decodable {
  var trims: [TrimDTO]?
}

extension TrimResponseDTO {

  func toDomain() -> [Trim] {

    guard let trims = trims else { return [] }
    return trims.compactMap { try? $0.toDomain() }

  }

}

struct TrimDTO: Decodable {
  var id: Int?
  var name: String?
  var description: String?
  var price: Int?
  var images: [String]?
  var options: [TrimOptionDTO]?
}

extension TrimDTO {
  func toDomain() throws -> Trim {
    return Trim()
  }
}

struct TrimOptionDTO: Decodable {
  var dataLabel: String?
  var frequency: Int?
}
