//
//  QuotationCompleteModel.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/21.
//

import Foundation

enum QuotationCompleteModel {

  struct State: Equatable {
    var summaryQuotation: SummaryCarQuotation
    var technicalSpec: ResultOfCalculationOfFuelAndDisplacement
    var nextNavIndex: Int
    var alertCase: QuotationCompleteView.AlertCase
    var showSheet: Bool 
    var showAlert: Bool
    var alertTitle: String
  }

  enum ViewAction {
    case onAppear
    case onTapModifyButton(navigationIndex: Int, title: String)
    case onTapDeleteButton(optionId: Int)
    case movePage(navigationIndex: Int)
    case deleteOption(optionId: Int)
    case showSheetChanged(showSheet: Bool)
    case showAlertChanged(showAlert: Bool)
  }
}
