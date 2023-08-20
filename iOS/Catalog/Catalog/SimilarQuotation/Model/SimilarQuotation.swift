//
//  SimilarQuotation.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/19.
//

import Foundation

struct SimilarQuotation: Equatable, Identifiable {
  var id: UUID?
  var powertrainName: String
  var bodytypeName: String
  var drivetrainName: String
  var price: CLNumber
  var image: URL?
  var options: [SimilarQuotationOption]
  
  static func mock() -> SimilarQuotation {
    .init(powertrainName: "디젤 2.2",
          bodytypeName: "7인승",
          drivetrainName: "2WD",
          price: CLNumber(23233), options: [
            SimilarQuotationOption.mock(),
            SimilarQuotationOption.mock()
          ])
  }
}
