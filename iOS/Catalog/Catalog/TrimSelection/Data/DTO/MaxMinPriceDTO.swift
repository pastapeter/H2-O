//
//  MaxMinPriceDTO.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/16.
//

import Foundation

struct MaxMinPriceDTO: Decodable {
  var maxPrice: Int?
  var minPrice: Int?
}

extension MaxMinPriceDTO {
  func toDomain() throws -> (maxPrice: CLNumber, minPrice: CLNumber) {
    let max = maxPrice ?? 99999999
    let min = minPrice ?? 0
    return (maxPrice: CLNumber(Int32(max)),
            minPrice: CLNumber(Int32(min)))
  }
}
