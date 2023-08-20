//
//  ModelTypeRequestDTO.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/14.
//

import Foundation

struct ModelTypeRequestDTO: Encodable {
  var carId: Int
}

struct FuelAndDisplacementRequestDTO: Encodable {
  var powertrainId: Int
  var drivetrainId: Int
}
