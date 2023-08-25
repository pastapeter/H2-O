//
//  ExtraOptionModel.swift
//  Catalog
//
//  Created by Jung peter on 8/19/23.
//

import Foundation

struct ExtraOptionModel: Encodable, Equatable, QuotationOptionable {
  var id: Int
  var isPackage: Bool
  var category: Category
  var name: String
  var imageURL: URL?
  var hashTags: [HashTag]
  var conainsHmgData: Bool
  var choiceRatio: Int
  var price: CLNumber?
  var isSimilarOption: Bool = false
}
