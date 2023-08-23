//
//  QuotationCompleteRequest.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/21.
//

import Foundation

enum QuotationCompleteRequest {
  case calculateFuelAndDisplacement(powertrainId: Int, drivetrainId: Int)
}

extension QuotationCompleteRequest: RequestProtocol {
  var host: String {
    return API.host
  }
  
  var path: String {
    switch self {
      case .calculateFuelAndDisplacement(let powertrainId, let drivetrainId):
        return "/technical-spec"
    }
  }
  
  var headers: [String : String] {
    return [:]
  }
  
  var params: [String : Any] {
    return [:]
  }
  
  var urlParams: [String : String?] {
    switch self {
      case .calculateFuelAndDisplacement(let powertrainId, let drivetrainId):
        return ["drivetrainId":"\(drivetrainId)", "powertrainId": "\(powertrainId)"]
      default:
        return [:]
    }
  }
  
  var requestType: RequestType {
    switch self {
      case .calculateFuelAndDisplacement(_, _):
        return .GET
    }
  }
  
  var cachePolicy: URLRequest.CachePolicy {
      return .returnCacheDataElseLoad
  }
  
  var secureType: SecureType {
    return .http
  }
  
}
