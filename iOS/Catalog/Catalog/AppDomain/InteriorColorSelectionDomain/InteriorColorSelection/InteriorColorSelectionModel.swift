//
//  InteriorColorSelectionModel.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import Foundation

enum InteriorColorSelectionModel {

  struct ViewState: Equatable {
    var selectedTrimID: Int
    var selectedColorId: Int
    var trimColors: [InteriorColorState]
    var selectedInteriorImageURL: URL?
  }
  
  struct State: Equatable {
    
  }

  enum ViewAction {
    case onAppear
    case trimColors(colors: [InteriorColor])
    case changeSelectedInteriorImageURL(url: URL?)
    case onTapColor(id: Int)
  }

}
