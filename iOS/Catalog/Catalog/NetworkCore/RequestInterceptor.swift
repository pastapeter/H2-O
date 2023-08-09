//
//  RequestInterceptor.swift
//  Catalog
//
//  Created by Jung peter on 8/9/23.
//

import Foundation

enum CLRetryResult {
  
  case retry
  
  case retryWithDelay(TimeInterval)
  
  case doNotRetry
  
  case doNotRetryWithError(Error)
  
}

extension CLRetryResult {
  
  var retryRequired: Bool {
    switch self {
    case .retry, .retryWithDelay:
      return true
    default:
      return false
    }
  }
  
  var error: Error? {
    guard case let .doNotRetryWithError(error) = self else {
      return nil
    }
    return error
  }
  
}

protocol RequestRetrier {
  
  func retry(_ request: URLRequest, for session: URLSession, dueTo error: Error) async throws -> CLRetryResult
  
}

protocol RequestInterceptor: RequestRetrier { }

extension RequestInterceptor {
  
  func retry(_ request: URLRequest, for session: URLSession, dueTo error: Error) async throws -> CLRetryResult {
    return .doNotRetry
  }
  
}
