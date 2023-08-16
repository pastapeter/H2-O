//
//  ExteriorColorRequest.swift
//  Catalog
//
//  Created by Jung peter on 8/16/23.
//

import Foundation

enum ExteriorColorRequest {
  case fetch(trimId: Int)
}

extension ExteriorColorRequest: RequestProtocol {

  var host: String {
    return API.host
  }

  var path: String {
    switch self {
    case .fetch(let trimId):
      return "/trim/\(trimId)/external-color"
    }
  }

  var headers: [String: String] {
    [:]
  }

  var params: [String: Any] {
    [:]
  }

  var urlParams: [String: String?] {
    [:]
  }

  var requestType: RequestType {
    .GET
  }

  var cachePolicy: URLRequest.CachePolicy {
    switch self {
    case .fetch:
      return .reloadRevalidatingCacheData
    }
  }

  var secureType: SecureType {
    return .http
  }

}
