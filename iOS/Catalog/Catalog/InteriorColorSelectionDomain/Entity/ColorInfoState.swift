//
//  ColorInfoState.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import Foundation

struct ColorInfoState: Equatable {
  var isSelected: Bool
  var id: Int
  var name: String
  var choiceRatio: CLNumber?
  var price: CLNumber
  var colorType: CarColorType
}
