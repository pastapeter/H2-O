//
//  URLSessionProtocol.swift
//  Catalog
//
//  Created by Jung peter on 8/8/23.
//

import Foundation

protocol URLSessionProtocol: AnyObject {

  func makeData(for urlRequest: URLRequest) async throws -> (data: Data, response: URLResponse)

  func makeData(from url: URL) async throws -> (data: Data, response: URLResponse)

  func makeData(from request: Request) async throws -> (data: Data, response: URLResponse)

}

extension URLSession: URLSessionProtocol {

  func makeData(from url: URL) async throws -> (data: Data, response: URLResponse) {
    return try await data(from: url)
  }

  func makeData(for urlRequest: URLRequest) async throws -> (data: Data, response: URLResponse) {
    return try await data(for: urlRequest)
  }

  func makeData(from request: Request) async throws -> (data: Data, response: URLResponse) {
    return try await data(for: request.urlRequest)
  }

}
