//
//  OptionSelectionModel.swift
//  Catalog
//
//  Created by Jung peter on 8/17/23.
//

import Foundation

enum OptionSelectionModel {

  struct State: Equatable {
    var currentPage: Int
    var optionMenuTitle = ["추가옵션", "기본옵션"]
    var additionalOptionState: OptionListState
    var defaultOptionState: OptionListState
  }

  enum ViewAction {
    case onTapTab(index: Int)
  }

}

struct OptionListState: Equatable {
  var filters = OptionFilter.additionalOptionFilter
  var cardStates: [OptionCardModel.State]
  var selectedFilterId: Int
}


