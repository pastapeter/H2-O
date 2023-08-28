//
//  CLApiRetrier.swift
//  Catalog
//
//  Created by Jung peter on 8/9/23.
//

import Foundation

class CLAPIRetrier: RequestRetrier {

  private let retryLimit: Int

  init(retryLimit: Int = 3) {
    self.retryLimit = retryLimit
  }

  func retry(_ request: Request, for session: URLSessionProtocol, dueTo error: Error) async throws -> CLRetryResult {
    let (data, response) = try await session.makeData(from: request)
    guard let response = response as? HTTPURLResponse else { return .doNotRetryWithError(error) }

    if response.statusCode >= 200 && response.statusCode < 300 {
      return .doNotRetryWithSuccess(data)
    }

    switch response.statusCode {
    case 13:
      if request.retryCount < retryLimit {
        return .retry
      } else {
        return .doNotRetryWithError(CLNetworkError.retryFailed(reason: .timeOut))
      }
    default:
      return .doNotRetryWithError(CLNetworkError.invalidServerResponse(reason: response.statusCode))
    }

  }

}
