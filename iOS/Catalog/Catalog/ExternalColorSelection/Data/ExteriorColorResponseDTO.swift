//
//  ExteriorColorResponseDTO.swift
//  Catalog
//
//  Created by Jung peter on 8/16/23.
//

import Foundation

struct ExteriorColorResponseDTO: Decodable {
  let id: Int?
  let name: String?
  let choiceRatio: Double?
  let price: Int?
  let hexCode: String?
  let images: [String]?
}

extension ExteriorColorResponseDTO {
  
  func toDomain() throws -> ExteriorColor
  
}
