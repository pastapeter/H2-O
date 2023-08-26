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

  var port: Int? { get }

  var urlParams: [String: String?] { get }

  var requestType: RequestType { get }

  var cachePolicy: URLRequest.CachePolicy { get }

  var timeOutInterval: TimeInterval { get }

  var contentType: ContentType { get }

  var secureType: SecureType { get }

}

extension RequestProtocol {

  var contentType: ContentType {
    .JSON
  }
  
  var secureType: SecureType {
    .https
  }

  var timeOutInterval: TimeInterval {
    10
  }

  var port: Int? {
    nil
  }

  func createRequest() throws -> Request {

    var components = URLComponents()
    components.scheme = self.secureType.description
    components.host = host
    components.port = port
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
    
    if let httpBody = urlRequest.httpBody, let json = try? JSONSerialization.jsonObject(with: httpBody, options: []) as? [String : Any] {
         print(json)
       }
    
    return Request(urlRequest: urlRequest)
  }

}
