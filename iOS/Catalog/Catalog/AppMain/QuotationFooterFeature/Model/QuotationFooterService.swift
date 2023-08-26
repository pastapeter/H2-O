//
//  QuotationFooterService.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/24.
//

import Foundation
import Combine


protocol QuotationFooterService {
  
  var totalPricePublisher: Published<CLNumber>.Publisher { get }
  
  func summaryQuotation() -> SummaryCarQuotation
  
  func quotationInQuotationFooter() -> CarQuotation
  
  var quotation: CarQuotation { get }
    
  
}

extension Quotation: QuotationFooterService {
  
  var totalPricePublisher: Published<CLNumber>.Publisher {
    $totalPrice
  }
  

  func summaryQuotation() -> SummaryCarQuotation {
    quotation.toSummary()
  }
  
  func quotationInQuotationFooter() -> CarQuotation {
    quotation
  }

}
