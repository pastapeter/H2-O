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
  private let interceptor: RequestInterceptor?
  private let cachedResponseHandler: CachedResponseHandler?

  init(urlSession: URLSession,
       intercepter: RequestInterceptor? = nil,
       cachedResponseHandler: CachedResponseHandler? = nil) {
    self.urlSession = urlSession
    self.cachedResponseHandler = cachedResponseHandler
    self.interceptor = intercepter
  }

  convenience init(configuation: URLSessionConfiguration = URLSessionConfiguration.default,
                   interceptor: RequestInterceptor? = nil,
                   cachedResponseHandler: CachedResponseHandler? = nil) {
    let session = URLSession(configuration: configuation)
    self.init(urlSession: session, intercepter: interceptor, cachedResponseHandler: cachedResponseHandler)
  }

  func perform(_ request: RequestProtocol) async throws -> Data {

    let (data, response) = try await urlSession.makeData(for: request.createRequest())
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
      throw CLNetworkError.invalidServerResponse
    }
    return data
  }

}
