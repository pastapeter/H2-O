//
//  QuotationRequest.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/21.
//

import Foundation

enum QuotationRequest {
  case saveFinalQuotation(dto: QuotationRequestDTO)
}

extension QuotationRequest: RequestProtocol {
  var host: String {
    return API.host
  }
  
  var path: String {
    switch self {
      case .saveFinalQuotation(_):
        return "/quotation"
    }
  }
  
  var headers: [String : String] {
    return [:]
  }
  
  var params: [String : Any] {
    switch self {
      case .saveFinalQuotation(let dto):
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
    switch self {
      case .saveFinalQuotation(_):
        return .POST
    }
  }
  
  var cachePolicy: URLRequest.CachePolicy {
    switch self {
      default:
        return .useProtocolCachePolicy
    }
  }
  
  var secureType: SecureType {
    return .http
  }
}
