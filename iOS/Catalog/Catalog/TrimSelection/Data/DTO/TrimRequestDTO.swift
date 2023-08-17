//
//  TrimRequestDTO.swift
//  Catalog
//
//  Created by Jung peter on 8/9/23.
//

import Foundation

struct TrimRequestDTO: Encodable {
  var carId: Int
}

struct TrimDefaultOptionRequestDTO: Encodable {
  var trimId: Int
}
