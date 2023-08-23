//
//  SimilarQuotationRepository.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/21.
//

import Foundation

struct SimilarQuotationRepository: SimilarQuotationRepositoryProtocol {
  
  private var requestManager: RequestManagerProtocol
  
  init(requestManager: RequestManagerProtocol) {
    self.requestManager = requestManager
  }
  
  func fetchSimilarQuotation(quotation: CarQuotation) async throws -> [SimilarQuotation] {
    let dto: [SimilarQuotationResponseDTO] = try await requestManager
      .perform( SimilarQuotationRequest.fetchSimilarQuotation(dto:
                                                      SimilarQuotationRequestDTO(carId: quotation.model.id,
                                                                                 trimId: quotation.trim.id,
                                                                                 modelTypeIds: ModelTypeIDRequestDTO(powertrainId: quotation.powertrain.id, bodyTypeId: quotation.bodytype.id, drivetrainId: quotation.drivetrain.id),
                                                                                 internalColorId: quotation.internalColor.id,
                                                                                 externalColorId: quotation.externalColor.id,
                                                                                 optionIds: quotation.options.filter{!$0.isPackage}.map{$0.id},
                                                                                 packageIds: quotation.options.filter{$0.isPackage}.map{$0.id})))
    let entity: [SimilarQuotation] = dto.compactMap { do {
      return try $0.toDomain()
    } catch(let e) {
      print("\(e.localizedDescription)")
      return nil
    }}
    
    return entity
  }
}
