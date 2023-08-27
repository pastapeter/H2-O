//
//  OptionSelectionAPIManager.swift
//  Catalog
//
//  Created by Jung peter on 8/18/23.
//

import Foundation

final class OptionSelectionAPIManager: APIManager {
  
  override init(urlSession: URLSession, retrier: RequestRetrier? = nil, cachedResponseHandler: CachedResponseHandler? = nil) {
    super.init(urlSession: urlSession, retrier: retrier, cachedResponseHandler: cachedResponseHandler)
  }
  
}
