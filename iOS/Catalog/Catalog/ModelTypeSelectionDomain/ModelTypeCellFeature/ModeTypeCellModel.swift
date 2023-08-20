//
//  ModeTypeModel.swift
//  Catalog
//
//  Created by Jung peter on 8/13/23.
//

import Foundation

enum ModelTypeCellModel: Equatable {

  struct State: Equatable, Hashable {

    func hash(into hasher: inout Hasher) {
      hasher.combine(title)
    }

    var title: String = "파워트레인"
    var imageURL: URL?
    var containsHMGData = true
    var optionStates: [ModelTypeOptionState] = []
    var selectedIndex: Int = 0
    var selectedId: Int = 1
    var modelTypeDetailState: [ModelTypeDetailState] = []
    var isModalPresenting = false

  }

  enum ViewAction: Equatable {
    case onTapDetailButton(isPresenting: Bool)
    case onTapOptions(id: Int)
  }

}



struct ModelTypeOptionState: Equatable, Hashable {

  var id: Int
  var isSelected: Bool = true
  var choiceRatio: CLNumber?
  var title: String = "디젤"
  var price: CLNumber = .init(0)

}
