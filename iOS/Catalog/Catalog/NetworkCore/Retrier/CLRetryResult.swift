//
//  CLRetryResult.swift
//  Catalog
//
//  Created by Jung peter on 8/10/23.
//

import Foundation

enum CLRetryResult {

  case retry

  case doNotRetry

  case doNotRetryWithError(Error)
  
  case success(Data)

}

extension CLRetryResult {

  var retryRequired: Bool {
    switch self {
    case .retry:
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
