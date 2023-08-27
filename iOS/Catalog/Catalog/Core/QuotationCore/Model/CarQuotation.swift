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
              options.reduce(CLNumber(0)) { $0 + ($1.price ?? CLNumber(0)) }
  }

  func toSummary() -> SummaryCarQuotation {
    return SummaryCarQuotation(externalImage: trim.externalImage,
                               internalImage: trim.internalImage,
                               model: SummaryQuotationInfo(id: model.id,
                                                           index: 0,
                                                           title: model.title,
                                                           name: model.name,
                                                           price: model.price),
                               trim: SummaryQuotationInfo(id: trim.id,
                                                          index: 0,
                                                          title: "트림",
                                                          name: trim.name,
                                                          price: trim.price),
                               powertrain: SummaryQuotationInfo(id: powertrain.id,
                                                                index: 1,
                                                                title: "파워트레인",
                                                                name: powertrain.name,
                                                                price: powertrain.price,
                                                                image: powertrain.imageURL),
                               bodytype: SummaryQuotationInfo(id: bodytype.id,
                                                              index: 1,
                                                              title: "바디타입",
                                                              name: bodytype.name,
                                                              price: bodytype.price,
                                                              image: bodytype.imageURL),
                               drivetrain: SummaryQuotationInfo(id: drivetrain.id,
                                                                index: 1,
                                                                title: "구동방식",
                                                                name: drivetrain.name,
                                                                price: drivetrain.price,
                                                                image: drivetrain.imageURL),
                               externalColor: SummaryQuotationInfo(id: externalColor.id,
                                                                   index: 2,
                                                                   title: "외장색상",
                                                                   name: externalColor.name,
                                                                   price: externalColor.price,
                                                                   image: URL(string: externalColor.hexCode)),
                               internalColor: SummaryQuotationInfo(id: internalColor.id,
                                                                   index: 3,
                                                                   title: "내장색상",
                                                                   name: internalColor.name,
                                                                   price: internalColor.price,
                                                                   image: internalColor.fabricImageURL),
                               options: options.map { SummaryQuotationInfo(id: $0.id,
                                                                           index: 4,
                                                                           title: "추가옵션",
                                                                           name: $0.name,
                                                                           price: $0.price ?? CLNumber(0),
                                                                           image: $0.imageURL,
                                                                           isSimilarOption:               $0.isSimilarOption)
    }
    )
  }
  
  static func mock() -> CarQuotation {
    CarQuotation(trim: Trim(id: 0, name: "", description: "", price: CLNumber(0), hmgData: []),
                 powertrain: .init(id: 0, name: "", price: CLNumber(0)),
                 bodytype: .init(id: 0, name: "", price: CLNumber(0)),
                 drivetrain: .init(id: 0, name: "", price: CLNumber(0)),
                 externalColor: .init(id: 0, name: "", price: CLNumber(0), hexCode: "", exteriorImages: []),
                 internalColor: .init(id: 0, name: "", price: CLNumber(0)), options: [])
  }
}
