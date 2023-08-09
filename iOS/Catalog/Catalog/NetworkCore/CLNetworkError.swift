//
//  CLNetworkError.swift
//  Catalog
//
//  Created by Jung peter on 8/8/23.
//

import Foundation

enum CLNetworkError: Error {
  case invalidURL
  case urlRequestValidationFailed(reason: CLURLRequestFailureReason)
  case retryFailed
  case invalidServerResponse
}

enum CLURLRequestFailureReason {
  case bodyDataInGETRequest
}
