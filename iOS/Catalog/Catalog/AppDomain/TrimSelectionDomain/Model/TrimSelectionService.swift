//
//  TrimSelectionService.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/24.
//

import Foundation

protocol TrimSelectionService {
  
  func saveDefaultQuotation(trim: Trim, carQuotation: CarQuotation, minPrice: CLNumber, maxPrice: CLNumber)
    
}

extension Quotation: TrimSelectionService {
  func saveDefaultQuotation(trim: Trim, carQuotation: CarQuotation, minPrice: CLNumber, maxPrice: CLNumber) {
    
    quotation = CarQuotation(trim: trim, powertrain: carQuotation.powertrain, bodytype: carQuotation.bodytype, drivetrain: carQuotation.drivetrain, externalColor: carQuotation.externalColor, internalColor: carQuotation.internalColor, options: carQuotation.options)
    
    self.maxPrice = maxPrice
    self.minPrice = minPrice
    totalPrice = quotation.calculateTotalPrice()
    
  }
}

