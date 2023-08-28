//
//  CLBudgetPriceService.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/24.
//

import Foundation

protocol CLBudgetPriceService {
  
  func totalPriceInBudgetPrice() -> CLNumber
  
  var totalPricePublisher: Published<CLNumber>.Publisher { get }
  var hasExtraOption: Bool { get }
  var minPrice: CLNumber { get }
  var maxPrice: CLNumber { get }
  
}

extension Quotation: CLBudgetPriceService {
  
  func totalPriceInBudgetPrice() -> CLNumber {
    return totalPrice
  }
  var hasExtraOption: Bool {
    if quotation.options.isEmpty {
      return false
    } else {
      return true
    }
  }

}
