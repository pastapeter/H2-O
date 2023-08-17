//
//  TrimDTO.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/16.
//

import Foundation

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
    return Trim(    id: id ?? 1234,
                    name: name ?? "르블랑",
                    description: description ?? "",
                    price: CLNumber(Int32(price ?? 0)),
                    externalImage: URL(string: images?[0] ?? ""),
                    internalImage: URL(string: images?[1] ?? ""),
                    hmgData: options?.map { $0.toDomain() } ?? [])
  }
}
