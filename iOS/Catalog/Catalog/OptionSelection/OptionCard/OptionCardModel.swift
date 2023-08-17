//
//  OptionCardModel.swift
//  Catalog
//
//  Created by Jung peter on 8/18/23.
//

import Foundation

enum OptionCardModel {

  struct State: Equatable {
    var hashTag: [String]
    var info: ModelTypeContent
    var isModalPresenting = false
  }

  enum ViewAction {
    case onTapDetail(isPresenting: Bool)
  }

}
