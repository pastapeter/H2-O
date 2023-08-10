//
//  TrimSelectionRequest.swift
//  Catalog
//
//  Created by Jung peter on 8/9/23.
//

import Foundation

enum TrimSelectionRequest {
  case fetchTrimList(vehicleId: Int)
}

extension TrimSelectionRequest: RequestProtocol {

  var host: String {
    return TrimAPIConstant.host
  }

  var path: String {
    switch self {
    case .fetchTrimList(let vehicleID):
      return "/vehicle/\(vehicleID)"
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
    switch self {
    case .fetchTrimList:
      return .GET
    }
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

}
