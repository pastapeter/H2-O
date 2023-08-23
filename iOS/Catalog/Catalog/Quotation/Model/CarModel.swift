//
//  Model.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/21.
//

import Foundation

struct CarModel: Equatable {
  var id: Int
  var title: String
  var name: String
  var price: CLNumber
  var image: URL?
}
