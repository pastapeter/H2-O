//
//  APIManagerProtocol.swift
//  Catalog
//
//  Created by Jung peter on 8/8/23.
//

import Foundation

protocol APIManagerProtocol {
  func perform(_ request: RequestProtocol) async throws -> Data
}

class APIManager: APIManagerProtocol {

  private let urlSession: URLSessionProtocol
  private let retrier: RequestRetrier?
  private let cachedResponseHandler: CachedResponseHandler?

  init(urlSession: URLSession,
       retrier: RequestRetrier? = nil,
       cachedResponseHandler: CachedResponseHandler? = nil) {
    self.urlSession = urlSession
    self.cachedResponseHandler = cachedResponseHandler
    self.retrier = retrier
  }

  convenience init(configuation: URLSessionConfiguration = URLSessionConfiguration.default,
                   retrier: RequestRetrier? = nil,
                   cachedResponseHandler: CachedResponseHandler? = nil) {
    let session = URLSession(configuration: configuation)
    self.init(urlSession: session, retrier: retrier, cachedResponseHandler: cachedResponseHandler)
  }

  func perform(_ request: RequestProtocol) async throws -> Data {

    let requestObject = try request.createRequest()
    let (data, response) = try await urlSession.makeData(from: requestObject)
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
      // TODO: retryRequest 불러야함 -> 재귀써야함
      throw CLNetworkError.invalidServerResponse
    }

    return data
  }

}

// MARK: - Extension

extension APIManager {

  private func retryRequest(_ request: Request, dueTo error: CLNetworkError, completion: @escaping (CLRetryResult) -> Void) {

    guard let retrier = self.retrier else { return }

    retrier.retry(request, for: urlSession, dueTo: error) { retryResult in

      guard let retryResultError = retryResult.error else {
        completion(retryResult)
        return
      }

      let retryError = CLNetworkError.retryFailed
      completion(.doNotRetryWithError(retryError))

    }
  }

}
