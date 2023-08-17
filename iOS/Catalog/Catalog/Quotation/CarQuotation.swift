//
//  CarQuotation.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/09.
//

import Foundation
import UIKit

struct SummaryQuotationInfo {
  var name: String
  var price: CLNumber
}

struct SummaryCarQuotation {
  var externalImage: URL?
  var internalImage: URL?
  var model: SummaryQuotationInfo
  var trim: SummaryQuotationInfo
  var powertrain: SummaryQuotationInfo
  var bodytype: SummaryQuotationInfo
  var drivetrain: SummaryQuotationInfo
  var externalColor: SummaryQuotationInfo
  var internalColor: SummaryQuotationInfo
  var options: [SummaryQuotationInfo]
}

struct CarQuotation {
    var model: SummaryQuotationInfo = SummaryQuotationInfo(name: "팰리세이드", price: CLNumber(3880000))
    var trim: Trim
    var powertrain: PowerTrainModel
    var bodytype: BodyTypeModel
    var drivetrain: DriveTrainModel
    var externalColor: ExternalColorModel
    var internalColor: InternalColorModel
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
                               model: SummaryQuotationInfo(name: model.name, price: model.price),
                               trim: SummaryQuotationInfo(name: trim.name, price: trim.price),
                               powertrain: SummaryQuotationInfo(name: powertrain.name, price: powertrain.price),
                               bodytype: SummaryQuotationInfo(name: bodytype.name, price: bodytype.price),
                               drivetrain: SummaryQuotationInfo(name: drivetrain.name, price: drivetrain.price),
                               externalColor: SummaryQuotationInfo(name: externalColor.name,
                                                                   price: externalColor.price),
                               internalColor: SummaryQuotationInfo(name: internalColor.name,
                                                                   price: internalColor.price),
                               options: options.map { SummaryQuotationInfo(name: $0.name, price: $0.price) })
  }
}
