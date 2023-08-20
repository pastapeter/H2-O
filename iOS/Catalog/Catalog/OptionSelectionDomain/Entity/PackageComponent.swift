//
//  PackageComponent.swift
//  Catalog
//
//  Created by Jung peter on 8/19/23.
//

import Foundation

struct PackageComponent {
  
  let name: String
  let category: OptionCategory
  let image: URL?
  let description: String?
  let hashTags: [String]
  let useCount: Int?
  let price: Int
  let containsHmgData: Bool
  
}
