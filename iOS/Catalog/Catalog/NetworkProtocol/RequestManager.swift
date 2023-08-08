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
  
  func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T {
    
  }
  
}
