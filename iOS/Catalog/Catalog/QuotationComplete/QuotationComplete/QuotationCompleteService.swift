//
//  QuotationCompleteService.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/24.
//

import Foundation

protocol QuotationCompleteService {
  func powertrainId() -> Int
  func drivetrainId() -> Int
  func modelName() -> String
  func trimName() -> String
  func summary() -> SummaryCarQuotation
  func deleteSimilarOption(id: Int)
  func exteriorImage() -> URL?
  func interiorImage() -> URL?

}

extension Quotation: QuotationCompleteService {

  func powertrainId() -> Int {
    quotation.powertrain.id
  }
  
  func drivetrainId() -> Int {
    quotation.drivetrain.id
  }
  
  func modelName() -> String {
    quotation.model.name
  }
  func trimName() -> String {
    quotation.trim.name
  }
  
  func summary() -> SummaryCarQuotation {
    quotation.toSummary()
  }
  
  func deleteSimilarOption(id: Int) {
    quotation.options = quotation.options.filter({$0.id != id})
  }

  func exteriorImage() -> URL? {
    quotation.externalColor.exteriorImages[0]
  }
  
  func interiorImage() -> URL? {
    quotation.internalColor.bannerImageURL

  }
  
  
}
