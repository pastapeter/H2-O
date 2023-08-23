//
//  SimilarQuotationModel.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/19.
//

import Foundation

enum SimilarQuotationModel {

  struct State: Equatable {
    var currentSimilarQuotationIndex: Int
    var similarQuotations: [SimilarQuotation]
    var selectedOptions: [SimilarQuotationOption]
  }
  
  enum ViewAction: Equatable {
    case onAppear(quotation: CarQuotation)
    case currentSimilarQuotationIndexChanged(index: Int)
    case optionSelected(selectedOption: SimilarQuotationOption)
    case onTapAddButton
    case onTapBackButton
  }
}
