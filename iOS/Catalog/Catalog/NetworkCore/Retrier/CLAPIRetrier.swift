//
//  CLApiRetrier.swift
//  Catalog
//
//  Created by Jung peter on 8/9/23.
//

import Foundation

class CLAPIRetrier: CLRequestRetrier {

  let retryLimit = 3

  override func retry(_ request: Request,
                      for session: URLSessionProtocol,
                      dueTo error: Error,
                      completion: @escaping (CLRetryResult) -> Void) {

    Task {
      guard let response = try await session.makeData(for: request.urlRequest).response as? HTTPURLResponse else {
        completion(.doNotRetryWithError(error))
        return
      }

      switch response.statusCode {
      case 13: // timeout
        if request.retryCount < retryLimit {
          completion(.retry)
        } else {
          // TODO: 타임아웃끝나면 어떻게 설정해줄거임?
        }
      default:
        completion(.doNotRetry)
      }

    }

  }
}
