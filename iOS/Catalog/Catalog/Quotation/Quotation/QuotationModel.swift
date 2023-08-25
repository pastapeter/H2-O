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
    var quotation: CarQuotation
    var minPrice: CLNumber
    var maxPrice: CLNumber
  }
}
