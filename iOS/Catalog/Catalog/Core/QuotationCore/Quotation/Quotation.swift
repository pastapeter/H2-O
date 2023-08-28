//
//  QuotationState.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/16.
//

import Foundation
import Combine


final class Quotation {
    
  @Published var totalPrice: CLNumber = CLNumber(0)
  @Published var minPrice: CLNumber = CLNumber(0)
  @Published var maxPrice: CLNumber = CLNumber(99999999)
  @Published var quotation: CarQuotation = .mock()
}
