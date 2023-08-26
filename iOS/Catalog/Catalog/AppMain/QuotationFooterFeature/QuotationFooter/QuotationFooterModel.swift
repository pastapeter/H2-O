//
//  QuotationFooterModel.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/24.
//

import Foundation

enum QuotationFooterModel {
  
  struct State: Equatable {
    var totalPrice: CLNumber
    var summary: SummaryCarQuotation
  }
  
  enum ViewAction: Equatable {
    case priceChanged(price: CLNumber)
    case showSheet(showShet: Bool)
    case summaryChanged
    case onTapCompleteButton
    case onAppear
  }
}
