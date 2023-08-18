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
    guard let trimId = id else { throw TrimSelectionError.FailedToDomain }
    guard let trimName = name else { throw TrimSelectionError.FailedToDomain}
    guard let trimPrice = price else { throw TrimSelectionError.FailedToDomain}
    guard let trimImages = images else { throw TrimSelectionError.FailedToDomain}
    guard let trimOptions = options else { throw TrimSelectionError.FailedToDomain}

    return Trim(    id: trimId,
                    name: trimName,
                    description: description ?? "",
                    price: CLNumber(Int32(trimPrice)),
                    externalImage: URL(string: trimImages[0]),
                    internalImage: URL(string: trimImages[1]),
                    hmgData: trimOptions.compactMap { $0.toDomain() })
  }
}
