//
//  QuotationModel.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/16.
//

import Foundation

enum QuotationModel {

  struct State {
    var totalPrice: CLNumber
    var quotation: CarQuotation?
    var minPrice: CLNumber
    var maxPrice: CLNumber
  }

  enum ViewAction {
    case isTrimSelected(defaultCarQuotation: CarQuotation, minPrice: CLNumber, maxPrice: CLNumber)

    case isTrimChanged(trim: Trim)
    case isPowertrainChanged(powertrain: ModelTypeOption)
    case isBodyTypeChanged(bodytype: ModelTypeOption)
    case isDrivetrainChanged(drivetrain: ModelTypeOption)
    // TODO: - 색상 모델 채우기
    case isExternalColorChanged
    case isInternalColorChanged
    case isOptionChanged(option: ExtraOptionModel)
    case isPriceChanged
    case onTapCompleteButton
    case similarOptionsAdded(option: [any QuotationOptionable])
  }
}
