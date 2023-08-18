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
    var hashTag: [String]
    var info: ModelTypeContent
  }

  enum ViewAction {
    case onTapDetail
    case onTap(id: Int)
  }

}
