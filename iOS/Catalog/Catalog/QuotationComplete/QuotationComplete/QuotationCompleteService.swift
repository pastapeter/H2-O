//
//  QuotationCompleteService.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/21.
//

import Foundation

protocol QuotationCompleteService {
  func getPowertrainAndDriveTrain() -> (Int, Int)
  func getModelName() -> String
  func getSummary() -> SummaryCarQuotation
}
