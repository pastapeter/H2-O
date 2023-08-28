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
    
    configuation.urlCache = URLCache.shared
    let session = URLSession(configuration: configuation)
    self.init(urlSession: session, retrier: retrier, cachedResponseHandler: cachedResponseHandler)
  }

  func perform(_ request: RequestProtocol) async throws -> Data {
    
    let requestObject = try request.createRequest()
    
    //1. URLCache에서 cacheResponse 있는지
    
    if let cachedresponse = URLCache.shared.cachedResponse(for: requestObject.urlRequest) {
      Log.debug(message: "캐시에서 가져오는 중")
      return cachedresponse.data
    } else {
      
      let (data, response) = try await urlSession.makeData(from: requestObject)
      guard let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
        
        do {
          let (data, response) = try await urlSession.makeData(from: requestObject)
          
          guard let httpResponse = response as? HTTPURLResponse else { throw CLNetworkError.invalidURL }
          
          guard httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
            do {
              return try await retryRequestRecursively(requestObject, dueTo: .invalidServerResponse(reason: httpResponse.statusCode))
            } catch let e {
              throw e
            }
          }
          Log.debug(message: "서버에서 가져오는 중")
          return data
          
        } catch(let e) {
          
          if (e as? URLError)?.code == .timedOut {
            return try await retryRequestRecursively(requestObject, dueTo: .timeout)
          } else {
            Log.debug(message: "🚨 URLError \(e.localizedDescription)")
            return try await retryRequestRecursively(requestObject, dueTo: .URLError(message: (e as? URLError)?.localizedDescription))
          }
        }
        
      }
      
      return data
    }
    
  }

  func retryRequestRecursively(_ request: Request, dueTo error: CLNetworkError) async throws -> Data {

    // Result - retry 함수
    // 1. 만약에 200이 아니라면 Retrier에게 맡긴다.
    // 2. Retrier는 Status Code를 보고 어떠한 Result를 줄 수 있다.
    let result: CLRetryResult = try await retryRequest(request, dueTo: error)

    // 재귀함수의 탈출 지점
    // 3. Result에서 RetryRequired가 false인 경우
    if result.retryRequired == false {
      // 4. Result에 만약에 Data가 있다면, Retry를 중단하고 data를 내려보낸다.
      if let data = result.data {
        return data
      }
      // 5. retryError가 있다면, retryError를 방출한다.
      if let retryError = result.error {
        throw retryError
      }
      // 6. Result에 만약 Data가 아니라 retryRequired가 false가 된다면, 애러를 내려보낸다
      throw error
    }

    return try await retryRequestRecursively(request, dueTo: error)

  }

}

// MARK: - Extension

extension APIManager {

  private func retryRequest(_ request: Request, dueTo error: CLNetworkError) async throws -> CLRetryResult {

    guard let retrier = self.retrier else {
      return .doNotRetry
    }
    
    request.prepareForRetry()
    
     
    let retryResult = try await retrier.retry(request, for: urlSession, dueTo: error)
    
    guard let retryResultError = retryResult.error else {
      return retryResult
    }
    return .doNotRetryWithError(retryResultError)
  }

}
