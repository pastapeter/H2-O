//
//  QuotationFooterModel.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/24.
//

import Foundation

enum QuotationFooterModel {
  
  struct ViewState: Equatable {
    var totalPrice: CLNumber
    var summary: SummaryCarQuotation
  }
  
  struct State: Equatable {
    
  }
  
  enum ViewAction: Equatable {
    case priceChanged(price: CLNumber)
    case summaryChanged
    case onTapCompleteButton
    case onAppear
  }
}
