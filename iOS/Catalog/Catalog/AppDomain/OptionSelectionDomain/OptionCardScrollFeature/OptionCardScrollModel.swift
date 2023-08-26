//
//  OptionCardScrollModel.swift
//  Catalog
//
//  Created by Jung peter on 8/17/23.
//

import Foundation

enum OptionCardScrollModel {

  struct State {
    var filterState: FilterState = .init()
    var cardStates: [OptionCardModel.State]
    var selectedOptionId: Int = 0
    var startIndex: Int = 0
    var endIndex: Int = 0
    var isExtraOptionTab: Bool = true
    var error: Error?
  }

  enum ViewAction {
    case onAppear
    case onTapFilterButton(index: Int)
    case fetchCardState(from: Int, to: Int)
    case cardStates(states: [OptionCardModel.State])
    case onTapOption(id: OptionCardModel.State)
  }
}

