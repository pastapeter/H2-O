//
//  SimilarQuotationModel.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/19.
//

import Foundation

enum SimilarQuotationModel {

  struct ViewState: Equatable {
    var currentSimilarQuotationIndex: Int
    var similarQuotations: [SimilarQuotation]
    var selectedOptions: [SimilarQuotationOption]
    var alertCase: SimilarQuotationView.AlertCase
    var showAlert: Bool
    var currentSimilarQuotationPrice: CLNumber
  }
  
  struct State: Equatable {
    
  }
  
  enum ViewAction: Equatable {
    case onAppear(quotation: CarQuotation)
    case currentSimilarQuotationIndexChanged(index: Int)
    case optionSelected(selectedOption: SimilarQuotationOption)
    case onTapAddButton(title: String, count: Int)
    case onTapBackButton
    case onTapHelpButton
    case choiceQuit
    case choiceAdd
    case showAlertChanged(showAlert: Bool)
    case priceChanged(price: CLNumber)
  }
}
