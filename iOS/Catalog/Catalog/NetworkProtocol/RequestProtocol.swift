//
//  RequestProtocol.swift
//  Catalog
//
//  Created by Jung peter on 8/8/23.
//

import Foundation

protocol RequestProtocol {
  
  var path: String { get }

  var headers: [String: String] { get }
  
  var params: [String: Any] { get }

  var urlParams: [String: String?] { get }

  var requestType: RequestType { get }
  
}
