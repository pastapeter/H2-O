//
//  ExteriorColorResponseDTO.swift
//  Catalog
//
//  Created by Jung peter on 8/16/23.
//

import Foundation

enum ExteriorColorToDomainError: LocalizedError {
  case noIdInResponse
  case noNameInResponse
  case noChoiceRatioInResponse
  case noPriceInResponse
  case noHexCodeInResponse
}

struct ExteriorColorResponseDTO: Decodable {
  let id: Int?
  let name: String?
  let choiceRatio: Int?
  let price: Int?
  let hexCode: String?
  let images: [String]?
}

extension ExteriorColorResponseDTO {

  func toDomain() throws -> ExteriorColor {

    guard let id = id else { throw ExteriorColorToDomainError.noIdInResponse }
    guard let name = name else { throw ExteriorColorToDomainError.noNameInResponse }
    guard let price = price else { throw ExteriorColorToDomainError.noPriceInResponse }
    guard let hexCode = hexCode else { throw ExteriorColorToDomainError.noHexCodeInResponse }

    var domainChoiceRatio: CLNumber?
    if let choiceRatio = choiceRatio {
      domainChoiceRatio = CLNumber(Int32(choiceRatio ))
    }

    var exteriorImages: [URL] = []
    if let images = images {
      exteriorImages = images.compactMap { URL(string: $0) }
    }

    return ExteriorColor(id: id,
                         name: name,
                         choiceRatio: domainChoiceRatio,
                         price: CLNumber(Int32(price)),
                         hexCode: hexCode,
                         exteriorImages: exteriorImages)

  }

}
