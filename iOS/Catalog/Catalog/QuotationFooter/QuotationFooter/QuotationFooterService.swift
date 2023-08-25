//
//  QuotationFooterService.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/24.
//

import Foundation
import SwiftUI


protocol QuotationFooterService {
  
  var totalPrice : CLNumber { get }
  
  func summaryQuotation() -> SummaryCarQuotation
  
  func quotationInQuotationFooter() -> CarQuotation
  
  var quotation: CarQuotation { get }
    
  
}

extension Quotation: QuotationFooterService {
  
  
  func summaryQuotation() -> SummaryCarQuotation {
    quotation.toSummary()
  }
  
  func quotationInQuotationFooter() -> CarQuotation {
    quotation
  }

}
