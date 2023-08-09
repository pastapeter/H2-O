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

    do {
      let (data, response) = try await urlSession.makeData(from: requestObject)
      guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        throw CLNetworkError.invalidServerResponse
      }
      return data
    } catch let e {
      retryRequest(requestObject, dueTo: e as! CLNetworkError) { <#CLRetryResult#> in
        <#code#>
      }
      
    }
  }
  
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

class CLRetrier: CLRequestRetrier {

  let retryLimit = 3

  override func retry(_ request: Request, for session: URLSessionProtocol, dueTo error: Error, completion: @escaping (CLRetryResult) -> Void) {

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
