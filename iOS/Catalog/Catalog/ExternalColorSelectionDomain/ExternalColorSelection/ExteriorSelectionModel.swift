//
//  ExternalSelectionModel.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import Foundation

enum ExteriorSelectionModel {

  struct ViewState: Equatable {
    var selectedTrimId: Int
    var selectedColorId: Int = 1
    var colors: [ExteriorColorState] = []
  }
  
  struct State: Equatable {
    
  }

  enum ViewAction {
    case onAppear
    case fetchColors(colors: [ExteriorColor])
    case changeSelectedExternalImageURL(url: [URL])
    case onTapColor(id: Int)
  }
}

struct ExteriorColorState: Equatable, Hashable {
  var isSelected: Bool
  var color: ExteriorColor
}
