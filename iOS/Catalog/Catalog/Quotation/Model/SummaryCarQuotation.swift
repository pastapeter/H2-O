//
//  SummaryCarQuotation.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/17.
//

import Foundation

struct SummaryQuotationInfo: Hashable, Equatable {
  var id: Int
  var index: Int
  var title: String
  var name: String
  var price: CLNumber
  var image: URL?
  var isSimilarOption: Bool = false
}

struct SummaryCarQuotation: Equatable {
  var externalImage: URL?
  var internalImage: URL?
  var model: SummaryQuotationInfo
  var trim: SummaryQuotationInfo
  var powertrain: SummaryQuotationInfo
  var bodytype: SummaryQuotationInfo
  var drivetrain: SummaryQuotationInfo
  var externalColor: SummaryQuotationInfo
  var internalColor: SummaryQuotationInfo
  var options: [SummaryQuotationInfo]
}

extension SummaryCarQuotation {
  static func mock() -> Self {
    return SummaryCarQuotation(
      model: SummaryQuotationInfo(id: 0, index: 0, title: "모델", name: "xx", price: CLNumber(0)),
      trim: SummaryQuotationInfo(id: 0, index: 0, title: "트림", name: "xx", price: CLNumber(0)),
      powertrain: SummaryQuotationInfo(id: 0, index: 1, title: "파워트레인", name: "xx", price: CLNumber(0)),
      bodytype: SummaryQuotationInfo(id: 0, index: 1, title: "바디타입", name: "xx", price: CLNumber(0)),
      drivetrain: SummaryQuotationInfo(id: 0, index: 1, title: "구동방식", name: "xx", price: CLNumber(0)),
      externalColor: SummaryQuotationInfo(id: 0, index: 2, title: "외장색상", name: "xx", price: CLNumber(0)),
      internalColor: SummaryQuotationInfo(id: 0, index: 3, title: "내장색상", name: "xx", price: CLNumber(0)),
      options: [])
  }
}
