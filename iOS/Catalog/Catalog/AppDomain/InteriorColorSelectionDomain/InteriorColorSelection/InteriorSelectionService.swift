//
//  InteriorSelectionService.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/24.
//

import Foundation

protocol InteriorSelectionService {
  
  func updateInteriorColor(to color: InteriorColor?)
  
}

extension Quotation: InteriorSelectionService {
  func updateInteriorColor(to color: InteriorColor?) {
    guard let color = color else { return }
    quotation.internalColor = color
    totalPrice = quotation.calculateTotalPrice()
  }

}
