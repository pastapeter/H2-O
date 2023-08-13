//
//  ModelTypeContent.swift
//  Catalog
//
//  Created by Jung peter on 8/14/23.
//

import Foundation

struct ModelTypeContent: Equatable {

  static func mock() -> Self {
    return ModelTypeContent(title: "디젤 2.2",
                            description: "높은 토크로 파워풀한 드라이빙이 가능하며, 차급대비 연비 효율이 우수합니다.",
                            frequency: 38,
                            imageURL: nil,
                            price: .init(2800000)
    )
  }

  var title: String
  var description: String
  var frequency: Int
  var imageURL: URL?
  var price: CLNumber
}
