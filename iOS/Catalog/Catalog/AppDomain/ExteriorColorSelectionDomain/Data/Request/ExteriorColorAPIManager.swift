//
//  ExteriorColorAPIManager.swift
//  Catalog
//
//  Created by Jung peter on 8/16/23.
//

import Foundation

final class ExteriorColorAPIManager: APIManager {

  override init(urlSession: URLSession, retrier: RequestRetrier? = nil, cachedResponseHandler: CachedResponseHandler? = nil) {
    super.init(urlSession: urlSession, retrier: retrier, cachedResponseHandler: cachedResponseHandler)
  }

}
