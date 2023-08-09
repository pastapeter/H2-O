//
//  RequestInterceptor.swift
//  Catalog
//
//  Created by Jung peter on 8/9/23.
//

import Foundation

enum CLRetryResult {

  case retry

  case doNotRetry

  case doNotRetryWithError(Error)

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

typealias RetryHandler = (Request,
                          URLSessionProtocol,
                          Error,
                          _ completion: @escaping (CLRetryResult) -> Void) -> Void

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

class CLRequestRetrier: RequestRetrier {

  private let retriers: [RequestRetrier]

  init(retriers: [RequestRetrier] = []) {
    self.retriers = retriers
  }

  func retry(_ request: Request,
             for session: URLSessionProtocol,
             dueTo error: Error,
             completion: @escaping (CLRetryResult) -> Void) {
    retry(request, for: session, dueTo: error,
          using: retriers, completion: completion)
  }

  private func retry(_ request: Request,
                     for session: URLSessionProtocol,
                     dueTo error: Error,
                     using retriers: [RequestRetrier],
                     completion: @escaping (CLRetryResult) -> Void) {

    var pendingRetriers = retriers

    guard !pendingRetriers.isEmpty else {
      completion(.doNotRetry)
      return
    }

    let retrier = pendingRetriers.removeFirst()

    retrier.retry(request, for: session, dueTo: error) { result in
      switch result {
      case .retry, .doNotRetryWithError:
        completion(result)
      case .doNotRetry:
        self.retry(request, for: session, dueTo: error, using: pendingRetriers, completion: completion)
      }
    }

  }

}
