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
    var optionStates: [OptionState] = [
      OptionState(id: .init(), isSelected: true, frequency: Int.random(in: 0...90), title: "디젤2.2", price: CLNumber(0)),
      OptionState(id: .init(), isSelected: false, frequency: 38, title: "가솔린3.8", price: CLNumber(280000))
    ]
    var selectedIndex: Int = 0
    var modelTypeDetailState: [ModelTypeDetailState] = []
    var isModalPresenting = false

  }

  enum ViewAction: Equatable {
    case onTapDetailButton(isPresenting: Bool)
    case onTapOptions(index: Int)
  }

}

struct ModelTypeDetailState: Equatable {
  var content: ModelTypeContent
  var hmgData: HMGDataState?
}

struct OptionState: Equatable, Identifiable, Hashable {

  var id: Int
  var isSelected: Bool = true
  var frequency: Int = 0
  var title: String = "디젤"
  var price: CLNumber = .init(0)

}
