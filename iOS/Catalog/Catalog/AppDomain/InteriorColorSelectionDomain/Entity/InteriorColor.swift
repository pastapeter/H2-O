//
//  InteriorColor.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import Foundation

struct InteriorColor: Equatable, Hashable, ColorProtocol {
  var id: Int
  var name: String
  var choiceRatio: CLNumber?
  var price: CLNumber
  var fabricImageURL: URL?
  var bannerImageURL: URL?
}
