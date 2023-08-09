//
//  CLApiRetrier.swift
//  Catalog
//
//  Created by Jung peter on 8/9/23.
//

import Foundation

class CLAPIRetrier: RequestRetrier {

  let retryLimit = 3

  func retry(_ request: Request,
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
          // 시도 다시함
          completion(.retry)
        } else {
          // TODO: 타임아웃끝나면 어떻게 설정해줄거임?
          // Alert보여주고
          // 다시 시도안해야함
          completion(.doNotRetry)
        }
      default:
        completion(.doNotRetry)
      }

    }

  }
  
  func retry(_ request: Request, for session: URLSessionProtocol, dueTo error: Error) async throws -> CLRetryResult {
    let (data, response) = try await session.makeData(from: request)
    guard let response = response as? HTTPURLResponse else { return .doNotRetryWithError(error) }
    
    
    switch response.statusCode {
    case 13:
      if request.retryCount < retryLimit {
        return .retry
      } else {
        return .doNotRetry
      }
    default:
      return .doNotRetry
    }
    
  }
  
  
  
  
}
