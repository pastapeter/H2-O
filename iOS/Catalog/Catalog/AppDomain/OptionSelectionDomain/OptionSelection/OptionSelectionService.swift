//
//  OptionSelectionService.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/24.
//

import Foundation

protocol OptionSelectionService {
  
  func updateOption(to options: [any QuotationOptionable])
  
}

extension Quotation: OptionSelectionService {
  func updateOption(to options: [any QuotationOptionable]) {
    self.quotation.options = options
    totalPrice = quotation.calculateTotalPrice()
  }
}
