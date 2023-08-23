//
//  CarQuotation.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/09.
//

import Foundation
import UIKit

struct CarQuotation: Equatable {
  static func == (lhs: CarQuotation, rhs: CarQuotation) -> Bool {
    lhs.id == rhs.id
  }
  
  var id: Int?
  var model: CarModel = CarModel(id: 1, title: "모델", name: "팰리세이드", price: CLNumber(3880000))
  var trim: Trim
  var powertrain: ModelTypeOption
  var bodytype: ModelTypeOption
  var drivetrain: ModelTypeOption
  var externalColor: ExteriorColor
  var internalColor: InteriorColor
  var options: [any QuotationOptionable]
}

extension CarQuotation {

  func calculateTotalPrice() -> CLNumber {
    
    return    model.price +
              trim.price +
              powertrain.price +
              bodytype.price +
              drivetrain.price +
              externalColor.price +
              internalColor.price +
              options.reduce(CLNumber(0)) { $0 + ($1.price) }
  }

  func toSummary() -> SummaryCarQuotation {
    return SummaryCarQuotation(externalImage: trim.externalImage,
                               internalImage: trim.internalImage,
                               model: SummaryQuotationInfo(index: 0, title: model.title, name: model.name, price: model.price),
                               trim: SummaryQuotationInfo(index: 0, title: "트림", name: trim.name, price: trim.price),
                               powertrain: SummaryQuotationInfo(index: 1,
                                                                title: "파워트레인",
                                                                name: powertrain.name,
                                                                price: powertrain.price,
                                                                image: powertrain.imageURL),
                               bodytype: SummaryQuotationInfo(index: 1,
                                                              title: "바디타입",
                                                              name: bodytype.name,
                                                              price: bodytype.price,
                                                              image: bodytype.imageURL),
                               drivetrain: SummaryQuotationInfo(index: 1,
                                                                title: "구동방식",
                                                                name: drivetrain.name,
                                                                price: drivetrain.price,
                                                                image: drivetrain.imageURL),
                               externalColor: SummaryQuotationInfo(index: 2,
                                                                   title: "외장색상",
                                                                   name: externalColor.name,
                                                                   price: externalColor.price,
                                                                   image: URL(string: externalColor.hexCode)),
                               internalColor: SummaryQuotationInfo(index: 3,
                                                                   title: "내장색상",
                                                                   name: internalColor.name,
                                                                   price: internalColor.price,
                                                                   image: internalColor.fabricImageURL),
                               options: options.map { SummaryQuotationInfo(index: 4,
                                                                           title: "추가옵션",
                                                                           name: $0.name,
                                                                           price: $0.price,
                                                                           image: $0.image,
                                                                           isSimilarOption:               $0.isSimilarOption)
    }
    )
  }
}
