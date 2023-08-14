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

struct HMGDatum {
  var optionTitle: String
  var optionFrequency: Int
}

extension TrimDTO {
  func toDomain() throws -> Trim {
    return Trim(    id: UUID(),
                    name: name ?? "르블랑",
                    description: description ?? "",
                    price: CLNumber(Int32(price ?? 0)),
                    imageURL: URL(string: images?[0] ?? ""),
                    hmgData: options?.map { $0.toDomain() } ?? [])
  }
}

struct TrimOptionDTO: Decodable {
  var dataLabel: String?
  var frequency: Int?
}

extension TrimOptionDTO {
  func toDomain() -> HMGDatum {
    return HMGDatum(optionTitle: dataLabel ?? "", optionFrequency: frequency ?? 0)
  }
}
