//
//  Encodable+.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/21.
//

import Foundation
// MARK: - Encodable Extension
extension Encodable {
 func asParameter() throws -> [String: Any] {
  let encoder = JSONEncoder()
  encoder.keyEncodingStrategy = .convertToSnakeCase
  let data = try encoder.encode(self)
  guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
      as? [String: Any] else {
   throw NSError()
  }
  return dictionary
 }
}
