//
//  CarQuotation.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/09.
//

import Foundation
import UIKit

struct CarQuotation: Equatable {
  var model: SummaryQuotationInfo = SummaryQuotationInfo(title: "모델", name: "팰리세이드", price: CLNumber(3880000))
  var trim: Trim
  var powertrain: PowerTrainModel
  var bodytype: BodyTypeModel
  var drivetrain: DriveTrainModel
  var externalColor: ExteriorColor
  var internalColor: InteriorColor
  var options: [ExtraOptionModel]
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
                               model: SummaryQuotationInfo(title: model.title, name: model.name, price: model.price),
                               trim: SummaryQuotationInfo(title: "트림", name: trim.name, price: trim.price),
                               powertrain: SummaryQuotationInfo(title: "파워트레인",
                                                                name: powertrain.name,
                                                                price: powertrain.price,
                                                                image: powertrain.image),
                               bodytype: SummaryQuotationInfo(title: "바디타입",
                                                              name: bodytype.name,
                                                              price: bodytype.price,
                                                              image: bodytype.image),
                               drivetrain: SummaryQuotationInfo(title: "구동방식",
                                                                name: drivetrain.name,
                                                                price: drivetrain.price,
                                                                image: drivetrain.image),
                               externalColor: SummaryQuotationInfo(title: "외장색상",
                                                                   name: externalColor.name,
                                                                   price: externalColor.price,
                                                                   image: URL(string: externalColor.hexCode)),
                               internalColor: SummaryQuotationInfo(title: "내장색상",
                                                                   name: internalColor.name,
                                                                   price: internalColor.price,
                                                                   image: internalColor.fabricImageURL),
                               options: options.map { SummaryQuotationInfo(title: "추가옵션",
                                                                           name: $0.name,
                                                                           price: $0.price,
                                                                           image: $0.image)
    }
    )
  }
}
