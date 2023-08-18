//
//  CLBudgetRangeModel.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/06.
//

import Foundation

enum CLBudgetRangeModel {

  struct State: Equatable {
    var status: CLBudgetRangeView.Status
    var currentQuotationPrice: CLNumber
    var budgetPrice: CLNumber
    var isExceedBudget: Bool
    var budgetGap: CLNumber
    var minimumPrice: CLNumber = CLNumber(0)
    var maximumPrice: CLNumber = CLNumber(0)

    init(currentQuotationPrice: CLNumber, budgetPrice: CLNumber, status: CLBudgetRangeView.Status) {
      self.currentQuotationPrice = currentQuotationPrice
      self.budgetPrice = budgetPrice
      self.isExceedBudget = (currentQuotationPrice > budgetPrice)
      self.budgetGap = CLNumber(abs(currentQuotationPrice.value - budgetPrice.value))
      self.status = status
    }
  }

  enum ViewAction: Equatable {
    case onAppear
    case budgetChanged(newBudgetPrice: CLNumber)
    case quotationPriceChanged(newQuotationPrice: CLNumber)
    case exceedBudgetChanged
    case budgetGapChanged
  }
}
