//
//  CachedResponseHandler.swift
//  Catalog
//
//  Created by Jung peter on 8/9/23.
//

import Foundation

protocol CachedResponseHandler {
  
  func dataTask(_ task: URLSessionDataTask,
                willCacheResponse response: CachedURLResponse) async -> CachedURLResponse?
  
}

struct CLResponseCacher: CachedResponseHandler {

  enum CacheBehavior {
    
    case cache
    
    case doNotCache
    
  }
  
  static let cache = CLResponseCacher(behavior: .cache)
  
  static let doNotCache = CLResponseCacher(behavior: .doNotCache)
  
  let behavior: CacheBehavior
  
  func dataTask(_ task: URLSessionDataTask, willCacheResponse response: CachedURLResponse) async -> CachedURLResponse? {

    switch behavior {
    case .cache:
      return response
    case .doNotCache:
      return nil
    }
  
  }
  
  
}
