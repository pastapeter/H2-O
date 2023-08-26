//
//  SimilarQuotation.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/19.
//

import Foundation

struct SimilarQuotation: Equatable, Identifiable {
  
  var id: UUID
  var powertrainName: String
  var bodytypeName: String
  var drivetrainName: String
  var price: CLNumber
  var image: URL?
  var options: [SimilarQuotationOption]
  
  static func mock() -> SimilarQuotation {
    .init(id: .init(), powertrainName: "",
          bodytypeName: "",
          drivetrainName: "",
          price: CLNumber(0), options: [
            SimilarQuotationOption.mock(),
            SimilarQuotationOption(
              id: 5,
              name: "",
              price: CLNumber(0))
          ])
  }
}
