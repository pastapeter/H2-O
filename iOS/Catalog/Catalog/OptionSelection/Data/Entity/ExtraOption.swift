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
<<<<<<< HEAD:iOS/Catalog/Catalog/OptionSelection/Domain/ExtraOptionModel.swift
  var image: URL?
  var hashTags: [HashTag]
  var conainsHmgData: Bool
  var choiceRatio: Int
=======
  var hashTags: [String]
  var containsHmgData: Bool
  var choiceRatio: CLNumber?
>>>>>>> 86e46e6 (feat: DefaultOption, ExttaOption entity 추가):iOS/Catalog/Catalog/OptionSelection/Data/Entity/ExtraOption.swift
  var price: CLNumber
  var image: URL?
  
}

