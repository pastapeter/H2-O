//
//  SimilarQuotationRequest.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/22.
//

import Foundation

enum SimilarQuotationRequest {
  case fetchSimilarQuotation(dto: SimilarQuotationRequestDTO)
}

extension SimilarQuotationRequest: RequestProtocol {
  var host: String {
    return API.host
  }
  
  var path: String {
    return "/quotation/similar"
  }
  
  var headers: [String : String] {
    return [:]
  }
  
  var params: [String : Any] {
    switch self {
      case .fetchSimilarQuotation(let dto):
        do {
          guard let params = try? dto.asParameter() else { return [:] }
          return params
        } catch {
          return [:]
        }
    }
  }
  
  var urlParams: [String : String?] {
    return [:]
  }
  
  var requestType: RequestType {
    .POST
  }
  
  var cachePolicy: URLRequest.CachePolicy {
    .useProtocolCachePolicy
  }
  
  var secureType: SecureType {
    .http
  }
}

