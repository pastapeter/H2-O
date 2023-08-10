//
//  SecureType.swift
//  Catalog
//
//  Created by Jung peter on 8/8/23.
//

import Foundation

enum SecureType {
  case https
  case http
}

extension SecureType: CustomStringConvertible {
  var description: String {
    switch self {
    case .https:
      return "https"
    case .http:
      return "http"
    }
  }
}
