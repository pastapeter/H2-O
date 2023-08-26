//
//  SimilarQuotationService.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/24.
//

import Foundation

protocol SimilarQuotationService {
  
  var quotation: CarQuotation { get }
  
  var totalPrice: CLNumber { get }
  
  func addSimilarOption(options: [any QuotationOptionable])
  
  var totalPriceInSimilarQuotation: Published<CLNumber>.Publisher { get }
  
}

extension Quotation: SimilarQuotationService {
  
  func addSimilarOption(options: [any QuotationOptionable]) {
    quotation.options.append(contentsOf: options)
    totalPrice = quotation.calculateTotalPrice()
  }
  
  var totalPriceInSimilarQuotation : Published<CLNumber>.Publisher {
    $totalPrice
  }

}
