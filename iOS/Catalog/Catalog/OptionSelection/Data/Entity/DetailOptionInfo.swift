//
//  DetailOption.swift
//  Catalog
//
//  Created by Jung peter on 8/18/23.
//

import Foundation

struct DetailOptionInfo {
  
  let category: OptionCategory
  let containsChoiceCount: Bool
  let containsUseCount: Bool
  let description: String?
  let hashTags: [String]
  let hmgData: HMGData?
  let image: URL?
  let name: String
  let price: CLNumber
  
  struct HMGData {
    var isOverHalf: Bool?
    var choiceCount: CLNumber?
    var useCount: CLNumber?
  }
  
}
