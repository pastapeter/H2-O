//
//  DetailOption.swift
//  Catalog
//
//  Created by Jung peter on 8/18/23.
//

import Foundation

struct DetailOptionInfo: ModalItemable, Equatable {
  static func == (lhs: DetailOptionInfo, rhs: DetailOptionInfo) -> Bool {
    return lhs.id == rhs.id
  }
  
  
  let id: Int
  let category: OptionCategory
  let containsChoiceCount: Bool
  let containsUseCount: Bool
  let description: String?
  let hashTags: [String]
  let hmgData: HMGData?
  let image: URL?
  let title: String
  let price: CLNumber
  
  struct HMGData {
    var isOverHalf: Bool?
    var choiceCount: CLNumber?
    var useCount: CLNumber?
  }
  
}

extension DetailOptionInfo {
  
  static func mock() -> Self {
    
    .init(id: .init(), category: .total, containsChoiceCount: false, containsUseCount: false, description: nil, hashTags: [], hmgData: nil, image: nil, title: "", price: CLNumber(0))
  }
  
}
