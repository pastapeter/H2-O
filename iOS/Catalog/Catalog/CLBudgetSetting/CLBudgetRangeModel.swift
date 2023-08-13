//
//  CLBudgetRangeModel.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/06.
//

import Foundation

enum CLBudgetRangeModel {

    struct State: Equatable {
        var currentQuotationPrice: CLNumber
        var budgetPrice: CLNumber
        var isExceedBudget: Bool
        var budgetGap: CLNumber

        init(currentQuotationPrice: CLNumber, budgetPrice: CLNumber) {
            self.currentQuotationPrice = currentQuotationPrice
            self.budgetPrice = budgetPrice
            self.isExceedBudget = (currentQuotationPrice > budgetPrice)
            self.budgetGap = CLNumber(abs(currentQuotationPrice.value - budgetPrice.value))
        }
    }

    enum ViewAction: Equatable {
        case isChangedBudget(newBudgetPrice: CLNumber)
        case isChangedQuotationPrice(newQuotationPrice: CLNumber)
        case isChangedExceedBudget
        case isChangedBudgetGap
    }
}
