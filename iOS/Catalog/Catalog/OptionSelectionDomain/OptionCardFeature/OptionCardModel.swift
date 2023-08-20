//
//  OptionCardModel.swift
//  Catalog
//
//  Created by Jung peter on 8/18/23.
//

import Foundation

enum OptionCardModel {

  struct State: Equatable, Hashable {
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
    
    var id: Int
    var hashTags: [String]
    var name: String
    var choiceRatio: CLNumber?
    var imageURL: URL?
    var price: CLNumber?
    var containsHmgData: Bool
    var category: OptionCategory
    
  }

  enum ViewAction {
    case onTapDetail
    case onTap(id: Int)
  }

}
