//
//  QuotationFooterRepositoryProtocol.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/21.
//

import Foundation

protocol QuotationFooterRepositoryProtocol {
  func saveFinalQuotation(with quotation: CarQuotation) async throws -> Int 
}
