//
//  QuotationCompleteRepositoryProtocol.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/21.
//

import Foundation

protocol QuotationCompleteRepositoryProtocol {
  
  func calculateFuelAndDisplacement(with powerTrainId: Int, andwith driverTrainId: Int)
  async throws -> ResultOfCalculationOfFuelAndDisplacement
}
