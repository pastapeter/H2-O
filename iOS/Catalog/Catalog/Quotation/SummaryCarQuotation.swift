//
//  SummaryCarQuotation.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/17.
//

import Foundation

struct SummaryQuotationInfo: Hashable {
  var title: String
  var name: String
  var price: CLNumber
  var image: URL?
}

struct SummaryCarQuotation {
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
