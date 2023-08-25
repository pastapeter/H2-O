//
//  ExteriorSelectionService.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/24.
//

import Foundation

protocol ExteriorSelectionService: AnyObject {
  func updateExteriorColor(to color: ExteriorColor)
}

extension Quotation: ExteriorSelectionService {
  func updateExteriorColor(to color: ExteriorColor) {
    quotation.externalColor = color
  }
}
