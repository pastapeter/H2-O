//
//  URLSessionProtocol.swift
//  Catalog
//
//  Created by Jung peter on 8/8/23.
//

import Foundation

protocol URLSessionProtocol: AnyObject {

  // URLSession 자체 모킹 - 테스트 코드 작성 시 사용
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
