//
//  ModelTypeRequest.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/14.
//

import Foundation

enum ModelTypeRequest {
  case fetchOptions(carId: Int)
  case calculateFuelAndDisplacementRequestDTO(powertrainId: Int, drivetrainId: Int)
}

extension ModelTypeRequest: RequestProtocol {
  var host: String {
    return API.host
  }
  var path: String {
    switch self {
      case .fetchOptions(let carId):
        return "/car/\(carId)/model-type"
      case .calculateFuelAndDisplacementRequestDTO(let powertrainId, let drivetrainId):
        return "/technical-spec?powertrainId=\(powertrainId)&drivetrainId=\(drivetrainId)"
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
      default:
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
