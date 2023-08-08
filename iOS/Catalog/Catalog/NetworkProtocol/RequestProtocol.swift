//
//  RequestProtocol.swift
//  Catalog
//
//  Created by Jung peter on 8/8/23.
//

import Foundation

protocol RequestProtocol {

  var host: String { get }

  var path: String { get }

  var headers: [String: String] { get }

  var params: [String: Any] { get }

  var urlParams: [String: String?] { get }

  var requestType: RequestType { get }

  var cachePolicy: URLRequest.CachePolicy { get }

  var timeOutInterval: TimeInterval { get }

  var contentType: ContentType { get }

}

extension RequestProtocol {

  func createRequest() throws -> URLRequest {

    var components = URLComponents()
    components.scheme = SecureType.https.description
    components.host = host
    components.path = path

    if !urlParams.isEmpty {
      components.queryItems = urlParams.map { URLQueryItem(name: $0, value: $1) }
    }

    guard let url = components.url else { throw CLNetworkError.invalidURL }

    var urlRequest = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeOutInterval)
    urlRequest.httpMethod = requestType.rawValue

    if !headers.isEmpty {
      urlRequest.allHTTPHeaderFields = headers
    }

    urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")

    // GET, JSONBody invalid
    if requestType == .GET && !params.isEmpty {
      throw CLNetworkError.urlRequestValidationFailed(reason: .bodyDataInGETRequest)
    }

    if !params.isEmpty {
      urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
    }

    return urlRequest
  }

}
