//
//  SimilarQuotationService.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/24.
//

import Foundation

protocol SimilarQuotationService {
  
  var quotation: CarQuotation { get }
  
  func addSimilarOption(options: [any QuotationOptionable])
  
  func totalPriceInSimilarQuotation() -> CLNumber
}

extension Quotation: SimilarQuotationService {
  
  func addSimilarOption(options: [any QuotationOptionable]) {
    quotation.options.append(contentsOf: options)
  }
  
  func totalPriceInSimilarQuotation() -> CLNumber {
    totalPrice
  }

}
