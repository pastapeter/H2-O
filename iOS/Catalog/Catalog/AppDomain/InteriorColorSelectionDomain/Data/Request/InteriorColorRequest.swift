//
//  InteriorColorRequest.swift
//  Catalog
//
//  Created by Jung peter on 8/16/23.
//

import Foundation

enum InteriorColorRequest {
  case fetch(trimId: Int)
}

extension InteriorColorRequest: RequestProtocol {
  var host: String {
    return API.host
  }

  var path: String {
    switch self {
    case .fetch(let trimId):
      return "/trim/\(trimId)/internal-color"
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
    .reloadRevalidatingCacheData
  }


}
