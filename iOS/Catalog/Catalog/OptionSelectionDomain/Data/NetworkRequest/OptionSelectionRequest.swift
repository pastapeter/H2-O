//
//  OptionSelectionRequest.swift
//  Catalog
//
//  Created by Jung peter on 8/18/23.
//

import Foundation

enum OptionSelectionRequest {
  
  case fetchDefaultOption(trimID: Int, from: Int, to: Int)
  
  case fetchExtraOption(trimID: Int, from: Int, to: Int)
  
  case fetchDetailOf(trimID: Int, optionID: Int)
  
  case fetchPackage(trimID: Int, packageID: Int)
  
  case fetchAllDefaultOption(trimID: Int)
  
  case fetchAllExtraOption(trimID: Int)
  
}

extension OptionSelectionRequest: RequestProtocol {
  
  var host: String {
    API.host
  }
 
  var path: String {
    switch self {
    case .fetchDefaultOption(let trimID, _, _), .fetchAllDefaultOption(let trimID):
      return "/trim/\(trimID)/default-option"
    case .fetchExtraOption(let trimID, _, _), .fetchAllExtraOption(let trimID):
       return "/trim/\(trimID)/extra-option"
    case .fetchDetailOf(let trimID, let optionID):
      return "/trim/\(trimID)/option/\(optionID)"
    case .fetchPackage(let trimID, let packageID):
      return "/trim/\(trimID)/package/\(packageID)"
    }
  }
  
  var headers: [String : String] {
    [:]
  }
  
  var params: [String : Any] {
    [:]
  }
  
  var urlParams: [String : String?] {
    switch self {
    case .fetchDefaultOption(_, let from, let to):
      return ["from": "\(from)", "to": "\(to)"]
    case .fetchExtraOption(_, let from, let to):
      return ["from": "\(from)", "to": "\(to)"]
    default:
      return [:]
    }
  }

    var requestType: RequestType {
      .GET
    }
  
  var cachePolicy: URLRequest.CachePolicy {
    //TODO: 같이 생각해보기
    .reloadIgnoringLocalCacheData
  }
  
    var secureType: SecureType {
      .http
    }
  
}
