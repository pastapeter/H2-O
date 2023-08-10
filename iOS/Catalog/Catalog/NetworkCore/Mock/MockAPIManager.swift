//
//  MockAPIManager.swift
//  Catalog
//
//  Created by Jung peter on 8/9/23.
//

import Foundation

final class MockAPIManager: APIManager {

  init() {
    let configuration = URLSessionConfiguration.default
    configuration.protocolClasses = [MockURLProtocol.self]
    super.init(urlSession: URLSession(configuration: configuration), retrier: CLAPIRetrier(retryLimit: 3))
  }

}
