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
  }

  enum ViewAction {
    case onAppear
    case onTapFilterButton(index: Int)
    case fetchCardState(cardStates: [OptionCardModel.State])
    case onTapOption(id: Int)
  }
}

extension OptionCardScrollModel.State {
  
  static func mock1() -> Self {
    return .init(filterState: .init(filters: OptionFilter.additionalOptionFilter, selectedFilterId: 0), cardStates: [.init(id: 0, hashTag: ["캠핑", "캠핑"], info: .init(title: "컴포트2", description: "", frequency: 38, price: CLNumber(38000)))], selectedOptionId: 0)
  }
  
  static func mock2() -> Self {
    return .init(filterState: .init(filters: OptionFilter.defaultOptionFiletr, selectedFilterId: 0), cardStates: [.init(id: 0, hashTag: ["캠핑", "캠핑"], info: .init(title: "컴포트2", description: "", frequency: 38, price: CLNumber(38000)))], selectedOptionId: 0)
  }
  
}
