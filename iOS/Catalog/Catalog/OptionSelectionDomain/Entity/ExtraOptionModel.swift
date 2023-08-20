//
//  ExtraOptionModel.swift
//  Catalog
//
//  Created by Jung peter on 8/19/23.
//

import Foundation

struct ExtraOptionModel: Encodable, Equatable {
  var id: Int
  var isPackage: Bool
  var category: Category
  var name: String
  var image: URL?
  var hashTags: [HashTag]
  var conainsHmgData: Bool
  var choiceRatio: Int
  var price: CLNumber
}
