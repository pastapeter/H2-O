//
//  PackageInfo.swift
//  Catalog
//
//  Created by Jung peter on 8/19/23.
//

import Foundation

struct PackageInfo {
  
  let name: String
  let category: OptionCategory = .total
  let price: Int
  let choiceRatio: Int?
  let choiceCount: Int?
  let isOverHalf: Bool?
  let hashTags: [String]
  let components: [PackageComponent]
  
}
