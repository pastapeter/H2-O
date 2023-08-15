//
//  InteriorColorResponseDTO.swift
//  Catalog
//
//  Created by Jung peter on 8/16/23.
//

import Foundation

struct InteriorColorResponseDTO: Decodable {
  let id: Int?
  let name: String?
  let choiceRatio: Int?
  let price: Int?
  let fabricImage: String?
  let bannerImage: String?
}
