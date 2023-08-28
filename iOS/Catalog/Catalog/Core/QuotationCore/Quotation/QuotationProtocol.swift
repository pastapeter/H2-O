//
//  QuotationProtocol.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/23.
//

import Foundation
import Combine

protocol TrimSelectionService {
  
  func saveDefaultQuotation(trim: Trim, carQuotation: CarQuotation, minPrice: CLNumber, maxPrice: CLNumber)
    
}

protocol ModeltypeSelectionService {
  
  func updateModelType(option: ModelTypeOption)
  
}

protocol ExteriorSelectionService {
  
  func updateExteriorColor(to color: ExteriorColor)
  
}

protocol InteriorSelectionService {
  
  func updateInteriorColor(to color: InteriorColor)
  
}

protocol OptionSelectionService {
  
  func updateOption(to option: some QuotationOptionable)
  
}

protocol QuotationCompleteService {
  func powertrainId() -> Int
  func privetrainId() -> Int
  func modelName() -> String
  func Summary() -> SummaryCarQuotation
  func deleteSimilarOption(id: Int)
}

protocol SimilarQuotationService {
  
  func quotation() -> CarQuotation
  
  func addSimilarOption(option: [any QuotationOptionable])
  
}

protocol QuotationFooterService {
  
  func totalPrice() -> CLNumber
  
  func summaryQuotation() -> SummaryCarQuotation
  
}
