//
//  OptionCardModel.swift
//  Catalog
//
//  Created by Jung peter on 8/18/23.
//

import Foundation

enum OptionCardModel {

  struct State: Equatable, Hashable {
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
    
    var id: Int
    var hashTags: [String]
    var name: String
    var choiceRatio: CLNumber?
    var imageURL: URL?
    var price: CLNumber?
    var containsHmgData: Bool
    var category: OptionCategory
    
  }

  enum ViewAction {
    case onTapDetail
    case onTap(id: Int)
  }

}

extension OptionCardModel.State {
  
  static func mock() -> [Self] {
      return [
        .init(id: 0, hashTags: ["캠핑", "장거리 운전", " 겨울운전"], name: "컴포트2", choiceRatio: CLNumber(38), price: CLNumber(1090000), containsHmgData: true, category: .accessory),
        .init(id: 1, hashTags: ["캠핑", "장거리 운전", " 겨울운전"], name: "듀얼 와이드 선루프", choiceRatio: CLNumber(38), price: CLNumber(890000), containsHmgData: false, category: .accessory),
        .init(id: 2, hashTags: ["캠핑", "장거리 운전", " 겨울운전"], name: "빌트인 캠", choiceRatio: CLNumber(38), price: CLNumber(69000), containsHmgData: false, category: .accessory),
        .init(id: 3, hashTags: ["캠핑", "장거리 운전", " 겨울운전"], name: "주차보조 시스템2", choiceRatio: CLNumber(38), price: CLNumber(1090000), containsHmgData: true, category: .accessory)
      ]

  }
  
  static func mock2() -> [Self] {
      return [
        .init(id: 0, hashTags: ["가성비"], name: "디젤2.2", containsHmgData: true, category: .accessory),
        .init(id: 1, hashTags: ["파워"], name: "8단 자동 변속기", containsHmgData: true, category: .accessory),
        .init(id: 2, hashTags: ["효율", "장거리 운전", " 연비"], name: "ISG 시스템",  containsHmgData: true, category: .accessory),
        .init(id: 3, hashTags: ["드라이빙", "장거리운전"], name: "통합주행모드", containsHmgData: true, category: .accessory)
      ]

  }
  
}
