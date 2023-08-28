//
//  Trim.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/14.
//

import Foundation

struct Trim: Identifiable, Equatable {
  static func == (lhs: Trim, rhs: Trim) -> Bool {
    return lhs.id == rhs.id
  }

  var id: Int
  var name: String
  var description: String
  var price: CLNumber
  var externalImage: URL?
  var internalImage: URL?
  var hmgData: [HMGDatum]
}
