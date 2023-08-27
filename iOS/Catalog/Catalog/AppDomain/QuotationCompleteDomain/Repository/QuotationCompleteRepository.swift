//
//  QuotationCompleteRepository.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/21.
//

import Foundation

final class QuotationCompleteRepository: QuotationCompleteRepositoryProtocol {

  private let quotationCompleteRequestManager: RequestManagerProtocol
  
  init(quotationCompleteRequestManager: RequestManagerProtocol) {
    self.quotationCompleteRequestManager = quotationCompleteRequestManager
  }
  
  func calculateFuelAndDisplacement(with powerTrainId: Int, andwith driverTrainId: Int) async throws -> ResultOfCalculationOfFuelAndDisplacement {
    
    let dto: TechnicalSpecResponseDTO = try await
    quotationCompleteRequestManager.perform(ModelTypeRequest.calculateFuelAndDisplacement(powertrainId: powerTrainId, drivetrainId: driverTrainId))
    
    return try dto.toDomain()
  }
}
