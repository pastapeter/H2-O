//
//  PackageComponent.swift
//  Catalog
//
//  Created by Jung peter on 8/19/23.
//

import Foundation

struct PackageComponent: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(name)
  }
  let name: String
  let category: OptionCategory
  let image: URL?
  let description: String?
  let hashTags: [String]
  let useCount: CLNumber?
  let containsHmgData: Bool
}
