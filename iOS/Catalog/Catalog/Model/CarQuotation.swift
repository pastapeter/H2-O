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
    var model: (name: String, price: CLNumber) = (name: "팰리세이드", price: CLNumber(3880000))
    var trim: (name: String, price: CLNumber) = (name: "Le Blanc (르블랑)", price: CLNumber(0))
    var powertrain: (name: String, price: CLNumber) = (name: "디젤 2.2", price: CLNumber(280000))
    var bodyType: (name: String, price: CLNumber) = (name: "7인승", price: CLNumber(0))
    var drivingMethod: (name: String, price: CLNumber) = (name: "2WD", price: CLNumber(0))
    var externalColor: (name: String, price: CLNumber) = (name: "어비스 블랙펄", price: CLNumber(150000))
    var internalColor: (name: String, price: CLNumber) = (name: "어비스 블랙펄", price: CLNumber(0))
    var options: [(name: String, price: CLNumber)] = [(name: "-", price: CLNumber(0)),
                                                     (name: "-", price: CLNumber(0)),
                                                     (name: "-", price: CLNumber(0)),
                                                     (name: "-", price: CLNumber(0))]
}
