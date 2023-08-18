//
//  ExtraOptionModel.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/15.
//

import Foundation

struct ExtraOptionModel: Encodable {
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
