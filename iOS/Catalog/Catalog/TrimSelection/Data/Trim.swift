//
//  Trim.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/14.
//

import Foundation

struct Trim: Identifiable, Equatable {
  static func == (lhs: Trim, rhs: Trim) -> Bool {
    return lhs.id == rhs.id
  }

  var id: UUID
  var name: String
  var description: String
  var price: CLNumber
  var imageURL: URL?
  var hmgData: [HMGDatum]

  static func mockTrim() -> Trim {
    return Trim(id: UUID(),
                name: "Le Blanc",
                description: "실용적인 사양의 경제적인 펠리세이드",
                price: CLNumber(40440000),
                hmgData: [HMGDatum(optionTitle: "안전 하차 보조", optionFrequency: 42),
                          HMGDatum(optionTitle: "후측방 충돌\n경고", optionFrequency: 42),
                          HMGDatum(optionTitle: "후방 교차\n충돌방지 보조", optionFrequency: 42)])
  }
}
