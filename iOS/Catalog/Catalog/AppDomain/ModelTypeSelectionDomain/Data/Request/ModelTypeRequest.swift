//
//  ModelTypeRequest.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/14.
//

import Foundation

enum ModelTypeRequest {
  case fetchOptions(carId: Int)
  case calculateFuelAndDisplacement(powertrainId: Int, drivetrainId: Int)
}

extension ModelTypeRequest: RequestProtocol {
  var host: String {
    return API.host
  }
  var path: String {
    switch self {
      case .fetchOptions(let carId):
        return "/car/\(carId)/model-type"
      case .calculateFuelAndDisplacement:
        return "/technical-spec"
    }
  }
  
  var headers: [String: String] {
    [:]
  }
  
  var params: [String: Any] {
    [:]
  }
  
  var requestType: RequestType {
    .GET
  }
  
  var cachePolicy: URLRequest.CachePolicy {
    switch self {
    case .fetchOptions:
      return .returnCacheDataElseLoad
    case .calculateFuelAndDisplacement:
      return .reloadIgnoringLocalCacheData
    }
    
  }

  var timeOutInterval: TimeInterval {
    return 2
  }
  
  var urlParams: [String: String?] {
    switch self {
    case .calculateFuelAndDisplacement(let powertrainId, let drivetrainId):
      return ["drivetrainId":"\(drivetrainId)", "powertrainId": "\(powertrainId)"]
    default:
      return [:]
    }
  }
  
}
