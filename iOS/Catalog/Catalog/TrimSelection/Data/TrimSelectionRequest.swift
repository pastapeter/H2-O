//
//  TrimSelectionRequest.swift
//  Catalog
//
//  Created by Jung peter on 8/9/23.
//

import Foundation

enum TrimSelectionRequest {
  case fetchTrimList(carId: Int)
  case fetchDefaultOption(trimId: Int)
  case fetchTrimMaxMinPrice(trimId: Int)
}

extension TrimSelectionRequest: RequestProtocol {

  var host: String {
    return API.host
  }

  var path: String {
    switch self {
    case .fetchTrimList(let carId):
      return "/car/\(carId)/trim"
    case .fetchDefaultOption(let trimId):
      return "/trim/\(trimId)/default-composition"
    case .fetchTrimMaxMinPrice(let trimId):
      return "/trim/\(trimId)/price-range"
    }
  }

  var headers: [String: String] {
    switch self {
    default:
      return [:]
    }
  }

  var params: [String: Any] {
    switch self {
    default:
      return [:]
    }
  }

  var requestType: RequestType {
    .GET
  }

  var cachePolicy: URLRequest.CachePolicy {
    return .returnCacheDataElseLoad
  }

  var timeOutInterval: TimeInterval {
    return 2
  }

  var urlParams: [String: String?] {
    return [:]
  }

  var secureType: SecureType {
    return .http
  }

}
