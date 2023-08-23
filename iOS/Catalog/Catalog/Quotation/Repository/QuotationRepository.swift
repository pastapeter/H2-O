//
//  QuotationRepository.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/21.
//

import Foundation

final class QuotationRepository: QuotationRepositoryProtocol {
  
  private let quotationRequestManager: RequestManagerProtocol
  
  init(quotationRequestManager: RequestManagerProtocol) {
    self.quotationRequestManager = quotationRequestManager
  }
  func saveFinalQuotation(with quotation: CarQuotation) async throws -> Int {
    let requestDTO = QuotationRequestDTO(carId: quotation.model.id,
                                         modelTypeIds: ModelTypeIDRequestDTO(powertrainId: quotation.powertrain.id, bodyTypeId: quotation.bodytype.id,
                                                                             drivetrainId: quotation.drivetrain.id), internalColorId: quotation.internalColor.id, externalColorId: quotation.externalColor.id, optionIds: quotation.options.filter{ !$0.isPackage }.map{ $0.id }, packageIds: quotation.options.filter{ $0.isPackage }.map{ $0.id }, trimId: quotation.trim.id)
    let dto: QuotationResponseDTO = try await quotationRequestManager.perform(QuotationRequest.saveFinalQuotation(dto: requestDTO))
    return try dto.toDomain()
  }
}
