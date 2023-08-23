//
//  SimilarQuotationMockRepository.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/22.
//

import Foundation

struct SimilarQuotationMockRepository: SimilarQuotationRepositoryProtocol {
    
  func fetchSimilarQuotation(quotation: CarQuotation) async throws -> [SimilarQuotation] {
    let manager = RequestManager(apiManager: MockAPIManager())
    guard let data = JSONLoader.load(with: "SimilarQuotations") else { return [] }
    let url = URL(string: "http://\(API.host):8080/quotation/similar")!
    MockURLProtocol.mockURLs = [
      url: (nil, data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil))
    ]
    let dto: [SimilarQuotationResponseDTO] = try await manager.perform( SimilarQuotationRequest.fetchSimilarQuotation(dto:
                                                      SimilarQuotationRequestDTO(carId: quotation.model.id,
                                                                                 trimId: quotation.trim.id,
                                                                                 modelTypeIds: ModelTypeIDRequestDTO(powertrainId: quotation.powertrain.id, bodyTypeId: quotation.bodytype.id,
                                                                                                                     drivetrainId: quotation.drivetrain.id),
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
