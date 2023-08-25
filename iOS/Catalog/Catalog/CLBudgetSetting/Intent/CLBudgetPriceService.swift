//
//  CLBudgetPriceService.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/24.
//

import Foundation

protocol CLBudgetPriceService {
  func totalPriceInBudgetPrice() -> CLNumber
  
  var minPrice: CLNumber { get }
  var maxPrice: CLNumber { get }
  
}

extension Quotation: CLBudgetPriceService {
  
  func totalPriceInBudgetPrice() -> CLNumber {
    return totalPrice
  }
  
}
