//
//  MockURLProtocol.swift
//  Catalog
//
//  Created by Jung peter on 8/8/23.
//

import Foundation

class MockURLProtocol: URLProtocol {

  static var mockURLs = [URL?: (error: Error?, data: Data?, response: HTTPURLResponse?)]()

  override class func canInit(with request: URLRequest) -> Bool {
    return true
  }

  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    return request
  }

  override func startLoading() {

    if let url = request.url {

      if let (error, data, response) = Self.mockURLs[url] {

        if let res = response {
          self.client?.urlProtocol(self, didReceive: res, cacheStoragePolicy: .allowed)
        }

        if let data = data {
          self.client?.urlProtocol(self, didLoad: data)
        }

        if let error = error {
          self.client?.urlProtocol(self, didFailWithError: error)
        }
      }
    }
    self.client?.urlProtocolDidFinishLoading(self)
  }

  override func stopLoading() {

  }

}
