//
//  ExtraOptionDTO.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/15.
//

import Foundation

struct OptionDTO: Decodable {
  var id: Int?
  var isPackage: Bool?
  var category: String?
  var name: String?
  var image: URL?
  var hashTags: [String?]
  var containsHmgData: Bool?
  var choiceRatio: Int?
  var price: Int?
}
