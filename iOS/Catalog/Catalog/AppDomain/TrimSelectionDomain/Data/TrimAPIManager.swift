//
//  TrimAPIManager.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/16.
//

import Foundation
final class  TrimAPIManager: APIManager {

  override init(urlSession: URLSession, retrier: RequestRetrier? = nil, cachedResponseHandler: CachedResponseHandler? = nil) {
    super.init(urlSession: urlSession, retrier: CLAPIRetrier())
  }
  
}
