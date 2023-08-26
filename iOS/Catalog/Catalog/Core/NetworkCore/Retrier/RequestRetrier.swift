//
//  RequestInterceptor.swift
//  Catalog
//
//  Created by Jung peter on 8/9/23.
//

import Foundation

protocol RequestRetrier {

  func retry(_ request: Request,
             for session: URLSessionProtocol,
             dueTo error: Error,
             completion: @escaping (CLRetryResult) -> Void)

  func retry(_ request: Request, for session: URLSessionProtocol, dueTo error: Error) async throws -> CLRetryResult

}

extension RequestRetrier {

  func retry(_ request: Request,
             for session: URLSessionProtocol,
             dueTo error: Error,
             completion: @escaping (CLRetryResult) -> Void) {
    completion(.doNotRetry)
  }

  func retry(_ request: Request, for session: URLSessionProtocol, dueTo error: Error) async throws -> CLRetryResult {
    return .doNotRetry
  }

}

// MARK: - CLRetrier

typealias RetryHandler = (Request,
                          URLSessionProtocol,
                          Error,
                          _ completion: @escaping (CLRetryResult) -> Void) -> Void

/// Closure 기반 Retrier이다.
final class CLRetrier: RequestRetrier {

  private let retryHandler: RetryHandler

  init(_ retryHandler: @escaping RetryHandler) {
    self.retryHandler = retryHandler
  }

  func retry(_ request: Request,
             for session: URLSessionProtocol,
             dueTo error: Error,
             completion: @escaping (CLRetryResult) -> Void) {
    retryHandler(request, session, error, completion)
  }

}
