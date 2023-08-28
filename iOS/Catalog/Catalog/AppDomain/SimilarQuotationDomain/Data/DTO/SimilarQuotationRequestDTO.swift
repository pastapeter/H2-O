//
//  SimilarQuotationRequestDTO.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/21.
//

import Foundation

struct SimilarQuotationRequestDTO: Encodable {
  var carId: Int
  var trimId: Int
  var modelTypeIds: ModelTypeIDRequestDTO
  var internalColorId: Int
  var externalColorId: Int
  var optionIds: [Int]
  var packageIds: [Int]
}
