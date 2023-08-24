//
//  CacheImage.swift
//  Catalog
//
//  Created by Jung peter on 8/23/23.
//

import Foundation

class CacheImageObject {
  
  var cacheImage: CacheImage
  
  init(cacheImage: CacheImage) {
    self.cacheImage = cacheImage
  }
  
}

struct CacheImage: Codable {
  
  let imageData: Data
  let etag: String
  
  init(imageData: Data, etag: String) {
    self.imageData = imageData
    self.etag = etag
  }
  
}


