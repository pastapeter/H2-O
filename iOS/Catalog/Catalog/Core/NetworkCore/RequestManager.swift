//
//  RequestManger.swift
//  Catalog
//
//  Created by Jung peter on 8/8/23.
//

import Foundation

protocol RequestManagerProtocol {
  func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T
}

final class RequestManager: RequestManagerProtocol {

  let apiManager: APIManagerProtocol
  let parser: DataParserProtocol

  init(apiManager: APIManagerProtocol, parser: DataParserProtocol = DataParser()) {
    self.apiManager = apiManager
    self.parser = parser
  }

  func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T {
    let data = try await apiManager.perform(request)

    let decoded: T = try parser.parse(data: data)

    return decoded
  }

}
