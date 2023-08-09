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

  init(urlRequest: URLRequest) {
    self.urlRequest = urlRequest
    self.retryCount = 0
  }
  
  func prepareForRetry() {
    retryCount += 1
  }
  
}
