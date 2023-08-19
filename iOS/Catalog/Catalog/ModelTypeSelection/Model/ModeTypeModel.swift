//
//  ModeTypeModel.swift
//  Catalog
//
//  Created by Jung peter on 8/13/23.
//

import Foundation

enum ModelTypeModel: Equatable {

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
    case onTapOptions(index: Int, id: Int)
  }

}

struct ModelTypeDetailState: Equatable, Identifiable {
  
  var id: Int
  var title: String
  var description: String?
  var choiceRatio: CLNumber?
  var imageURL: URL?
  var price: CLNumber
  var hmgData: HMGModelTypeState?
  
}

struct ModelTypeOptionState: Equatable, Hashable {

  var id: Int
  var isSelected: Bool = true
  var choiceRatio: CLNumber?
  var title: String = "디젤"
  var price: CLNumber = .init(0)

}
