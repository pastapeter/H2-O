//
//  QuotationAPIManager.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/21.
//

import Foundation

final class QuotationAPIManager: APIManager {
  
  override init(urlSession: URLSession, retrier: RequestRetrier? = nil, cachedResponseHandler: CachedResponseHandler? = nil) {
    super.init(urlSession: urlSession, retrier: retrier, cachedResponseHandler: cachedResponseHandler)
  }
  
}
