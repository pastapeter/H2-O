//
//  QuotationState.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/16.
//

import Foundation
import Combine


final class Quotation {
    
  var totalPrice: CLNumber = CLNumber(0)
  var minPrice: CLNumber = CLNumber(0)
  var maxPrice: CLNumber = CLNumber(99999999)
  var quotation: CarQuotation = .mock()
  
}
