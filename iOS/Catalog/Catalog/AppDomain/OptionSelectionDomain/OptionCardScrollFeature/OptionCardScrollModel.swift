//
//  OptionCardScrollModel.swift
//  Catalog
//
//  Created by Jung peter on 8/17/23.
//

import Foundation

enum OptionCardScrollModel {

  struct ViewState {
    var filterState: FilterState = .init()
    var cardStates: [OptionCardModel.ViewState]
    var selectedOptionId: Int = 0
    var startIndex: Int = 0
    var endIndex: Int = 0
    var isExtraOptionTab: Bool = true
    var error: Error?
  }
  
  struct State {
    
  }

  enum ViewAction {
    case onAppear
    case onTapFilterButton(index: Int)
    case fetchCardState(from: Int, to: Int)
    case cardStates(states: [OptionCardModel.ViewState])
    case onTapOption(id: OptionCardModel.ViewState)
  }
}

