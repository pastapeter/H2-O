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

protocol ColorRequestProtocol: RequestProtocol { }

extension ColorRequestProtocol {

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
}

extension ExteriorColorRequest: ColorRequestProtocol {

  var host: String {
    return API.host
  }

  var path: String {
    switch self {
    case .fetch(let trimId):
      return "/trim/\(trimId)/external-color"
    }
  }

  var cachePolicy: URLRequest.CachePolicy {
    switch self {
    case .fetch:
      return .reloadRevalidatingCacheData
    }
  }

}
