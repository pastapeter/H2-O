//
//  OptionCardScrollModel.swift
//  Catalog
//
//  Created by Jung peter on 8/17/23.
//

import Foundation

enum OptionCardScrollModel {
  
  struct State {
    var filters = OptionFilter.additionalOptionFilter
    var cardStates: [OptionCardModel.State]
    var selectedFilterId: Int = 0
    var startIndex: Int = 0
    var endIndex: Int = 0
  }
  
  enum ViewAction {
    case onAppear
    case onTapFilterButton(index: Int)
    case fetchCardState(cardStates: [OptionCardModel.State])
  }
}
