//
//  CarQuotation.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/09.
//

import Foundation

struct CarQuotation {
    var externalImage: String = "external_image"
    var internalImage: String = "internal_image"
    var model: (name: String, price: CLPrice) = (name: "팰리세이드", price: CLPrice(3880000))
    var trim: (name: String, price: CLPrice) = (name: "Le Blanc (르블랑)", price: CLPrice(0))
    var powertrain: (name: String, price: CLPrice) = (name: "디젤 2.2", price: CLPrice(280000))
    var bodyType: (name: String, price: CLPrice) = (name: "7인승", price: CLPrice(0))
    var drivingMethod: (name: String, price: CLPrice) = (name: "2WD", price: CLPrice(0))
    var externalColor: (name: String, price: CLPrice) = (name: "어비스 블랙펄", price: CLPrice(150000))
    var internalColor: (name: String, price: CLPrice) = (name: "어비스 블랙펄", price: CLPrice(0))
    var options: [(name: String, price: CLPrice)] = [(name: "-", price: CLPrice(0)),
                                                     (name: "-", price: CLPrice(0)),
                                                     (name: "-", price: CLPrice(0)),
                                                     (name: "-", price: CLPrice(0))]
}
