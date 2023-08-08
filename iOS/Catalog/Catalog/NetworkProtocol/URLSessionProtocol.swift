//
//  URLSessionProtocol.swift
//  Catalog
//
//  Created by Jung peter on 8/8/23.
//

import Foundation

protocol URLSessionProtocol: AnyObject {

  func makeData(for urlRequest: URLRequest) async throws -> (Data, URLResponse)

  func makeData(from url: URL) async throws -> (Data, URLResponse)

}

extension URLSession: URLSessionProtocol {

  func makeData(from url: URL) async throws -> (Data, URLResponse) {
    return try await data(from: url)
  }

  func makeData(for urlRequest: URLRequest) async throws -> (Data, URLResponse) {
    return try await data(for: urlRequest)
  }

}
