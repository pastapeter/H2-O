//
//  CarQuotation.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/09.
//

import Foundation

struct CarQuotation {
    var externalImage: String
    var internalImage: String
    var model: (name: String, price: CLNumber)
    var trim: (name: String, price: CLNumber)
    var powertrain: (name: String, price: CLNumber)
    var bodyType: (name: String, price: CLNumber)
    var drivingMethod: (name: String, price: CLNumber)
    var externalColor: (name: String, price: CLNumber)
    var internalColor: (name: String, price: CLNumber)
    var options: [(name: String, price: CLNumber)]

  static func mockQuotation() -> CarQuotation {
    CarQuotation(externalImage: "external_image",
                 internalImage: "internal_image",
                 model: (name: "팰리세이드", price: CLNumber(3880000)),
                 trim: (name: "Le Blanc (르블랑)", price: CLNumber(0)),
                 powertrain: (name: "디젤 2.2", price: CLNumber(280000)),
                 bodyType: (name: "7인승", price: CLNumber(0)),
                 drivingMethod: (name: "2WD", price: CLNumber(0)),
                 externalColor: (name: "어비스 블랙펄", price: CLNumber(150000)),
                 internalColor: (name: "어비스 블랙펄", price: CLNumber(0)),
                 options: [(name: "-", price: CLNumber(0)),
                           (name: "-", price: CLNumber(0)),
                           (name: "-", price: CLNumber(0)),
                           (name: "-", price: CLNumber(0))]
    )
  }
}
