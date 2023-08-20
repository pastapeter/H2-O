//
//  SimilarQuotationOption.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/19.
//

import Foundation

struct SimilarQuotationOption: Equatable, Identifiable {
  var isSelected: Bool
  var id: Int
  var name: String
  var image: URL?
  var price: CLNumber
  
  static func mock() -> SimilarQuotationOption {
    return .init(isSelected: false,
                 id: 2,
                 name: "컴포트",
                 price: CLNumber(1090000))
  }
}
