//
//  SimilarQuotationRepositoryProtocol.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/21.
//

import Foundation

protocol SimilarQuotationRepositoryProtocol {

  func fetchSimilarQuotation(quotation: CarQuotation) async throws -> [SimilarQuotation]
}
