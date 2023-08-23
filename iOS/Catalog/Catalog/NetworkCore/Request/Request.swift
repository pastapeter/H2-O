//
//  Request.swift
//  Catalog
//
//  Created by Jung peter on 8/9/23.
//

import Foundation

class Request {

  var urlRequest: URLRequest
  var retryCount: Int
  var serialQueue: DispatchQueue = .init(label: "RequestQueue")

  init(urlRequest: URLRequest) {
    self.urlRequest = urlRequest
    self.retryCount = 0
  }

  func prepareForRetry() {
    serialQueue.sync { [weak self] in
      self?.retryCount += 1
    }
  }

}
