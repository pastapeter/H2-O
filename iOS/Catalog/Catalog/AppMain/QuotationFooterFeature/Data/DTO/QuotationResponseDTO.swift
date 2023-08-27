//
//  QuotationResponseDTO.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/21.
//

import Foundation

enum QuotationError: Error {
  case noQuotationIdInRespoinse
  case cantCalculate
}

struct QuotationResponseDTO: Decodable {
  let quotationId: Int?
}

extension QuotationResponseDTO {
  func toDomain() throws -> Int {
    guard let id = quotationId else { throw QuotationError.noQuotationIdInRespoinse}
    return id
  }
}
