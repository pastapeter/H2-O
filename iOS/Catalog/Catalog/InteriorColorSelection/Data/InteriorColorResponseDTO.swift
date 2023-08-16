//
//  InteriorColorResponseDTO.swift
//  Catalog
//
//  Created by Jung peter on 8/16/23.
//

import Foundation

enum InteriorColorToDomainError: LocalizedError {
  case noIdInResponse
  case noNameInResponse
  case noChoiceRatioInResponse
  case noPriceInResponse
}

struct InteriorColorResponseDTO: Decodable {
  let id: Int?
  let name: String?
  let choiceRatio: Int?
  let price: Int?
  let fabricImage: String?
  let bannerImage: String?
}

extension InteriorColorResponseDTO {

  func toDomain() throws -> InteriorColor {

    guard let id = id else { throw InteriorColorToDomainError.noIdInResponse }
    guard let name = name else { throw InteriorColorToDomainError.noNameInResponse }
    guard let price = price else { throw InteriorColorToDomainError.noPriceInResponse }

    var fabricImageURL: URL?
    var bannerImageURL: URL?
    var domainChoiceRatio: CLNumber?

    if let fabricImageURLStr = fabricImage {
      fabricImageURL = URL(string: fabricImageURLStr)
    }

    if let bannerImageURLStr = bannerImage {
      bannerImageURL = URL(string: bannerImageURLStr)
    }

    if let choiceRatio = choiceRatio {
      domainChoiceRatio = CLNumber(Int32(choiceRatio))
    }

    return InteriorColor(id: id,
                         name: name,
                         choiceRatio: domainChoiceRatio,
                         price: CLNumber(Int32(price)),
                         fabricImageURL: fabricImageURL,
                         bannerImageURL: bannerImageURL)

  }

}
