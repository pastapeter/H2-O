//
//  PackageInfo.swift
//  Catalog
//
//  Created by Jung peter on 8/19/23.
//

import Foundation

struct PackageInfo: ModalItemable, Equatable {
  
  let id: Int
  let title: String
  let category: OptionCategory = .total
  let price: CLNumber
  let choiceRatio: CLNumber?
  let choiceCount: CLNumber?
  let isOverHalf: Bool?
  let hashTags: [String]
  let components: [PackageComponent]
  
}

extension PackageInfo {
  
  static func mock() -> Self {
    .init(id: .init(), title: "", price: .init(0), choiceRatio: nil, choiceCount: nil, isOverHalf: nil, hashTags: [], components: [])
  }
  
}
