//
//  ImageMemoryCache.swift
//  Catalog
//
//  Created by Jung peter on 8/23/23.
//

import Foundation

actor ImageMemoryCache {
  
  private var cache = NSCache<NSString, CacheImageObject>()
  
  func configureCachePolicy(with maximumMemoryBytes: Int) {
    cache.totalCostLimit = maximumMemoryBytes
  }
  
  func save(data: CacheImageObject, with key: String) {
    let key = NSString(string: key)
    self.cache.setObject(data, forKey: key)
  }
  
  func read(with key: String) -> CacheImage? {
    let key = NSString(string: key)
    return self.cache.object(forKey: key)?.cacheImage
  }
  
}
