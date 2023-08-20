//
//  SimilarQuotationModel.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/19.
//

import Foundation

enum SimilarQuotationModel {

  struct State: Equatable {

    var similarQuotations: [SimilarQuotation]
    var selectedOption: [SimilarQuotationOption]
  }
  
  enum ViewAction: Equatable {
    case onAppear(quotation: CarQuotation)
    case optionSelected(selectedOption: SimilarQuotationOption)
    case onTapAddButton
    case onTapBackButton
  }
}
