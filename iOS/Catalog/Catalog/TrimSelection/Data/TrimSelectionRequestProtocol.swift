//
//  TrimSelectionRequestProtocol.swift
//  Catalog
//
//  Created by Jung peter on 8/8/23.
//

import Foundation

protocol TrimSelectionRequestProtocol: RequestProtocol { }

extension TrimSelectionRequestProtocol {
  
  var host: String {
    TrimAPIConstant.host
  }
  
  var params: [String : Any] {
    [:]
  }
  
  var urlParams: [String : String?] {
    [:]
}
  
  var headers: [String : String] {
    [:]
  }
  
}
