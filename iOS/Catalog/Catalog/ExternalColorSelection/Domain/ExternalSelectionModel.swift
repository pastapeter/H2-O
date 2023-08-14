//
//  ExternalSelectionModel.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import Foundation

enum ExternalSelectionModel {

  struct State: Equatable {
    var selectedTrimId: Int
    var selectedColorId: Int = 1
    var colors: [ExternalColor] = []
  }

  enum ViewAction {
    case onAppear
    case fetchColors(colors: [ExternalColor])
  }
}
