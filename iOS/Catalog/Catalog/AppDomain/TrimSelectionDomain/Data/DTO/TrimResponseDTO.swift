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
