//
//  ExternalColor.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import Foundation

struct ExternalColor: Equatable, Hashable {
  var id: Int
  var name: String
  var choiceRatio: CLNumber
  var price: CLNumber
  var hexCode: String
}
