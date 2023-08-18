//
//  ExtraOptionModel.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/15.
//

import Foundation

struct ExtraOption {
  
  var id: Int
  var isPackage: Bool
  var category: OptionCategory
  var name: String
  var hashTags: [String]
  var containsHmgData: Bool
  var choiceRatio: CLNumber?
  var price: CLNumber
  var image: URL?
  
}

