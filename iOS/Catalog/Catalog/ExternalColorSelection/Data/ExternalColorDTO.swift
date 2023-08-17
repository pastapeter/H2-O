//
//  ExternalColorDTO.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/15.
//

import Foundation

struct ExternalColorDTO: Decodable {
  var id: Int?
  var name: String?
  var choiceRatio: Int?
  var price: Int?
  var hexCode: String?
  var images: [String]?
}

extension ExternalColorDTO {
  func toDomain() throws -> ExternalColorModel {

    return ExternalColorModel(
                              id: id ?? 0,
                              name: name ?? "",
                              choiceRatio: choiceRatio ?? 0,
                              price: CLNumber(Int32(price ?? 0)),
                              hexCode: hexCode ?? "",
                              images: (images ?? []).map({ URL(string: ($0 ?? "")) }))
  }
}
