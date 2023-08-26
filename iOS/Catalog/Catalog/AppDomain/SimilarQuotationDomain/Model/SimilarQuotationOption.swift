//
//  SimilarQuotationOption.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/19.
//

import Foundation

struct SimilarQuotationOption: Equatable, Identifiable, QuotationOptionable {
  
  var id: Int
  var name: String
  var imageURL: URL?
  var price: CLNumber?
  var isPackage: Bool = false
  var isSimilarOption: Bool = true

  
  static func mock() -> SimilarQuotationOption {
    return .init(id: 2,
                 name: "컴포트",
                 price: CLNumber(1090000))
  }
}

protocol QuotationOptionable: Equatable {
  var id: Int { get set }
  var name: String { get set }
  var imageURL: URL? { get set }
  var price: CLNumber? { get set }
  var isPackage: Bool { get set }
  var isSimilarOption: Bool { get set }
}
