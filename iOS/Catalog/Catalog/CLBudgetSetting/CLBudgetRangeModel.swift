//
//  CLBudgetRangeModel.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/06.
//

import Foundation

enum CLBudgetRangeModel {

    struct State: Equatable {
        var currentQuotationPrice: CLPrice
        var budgetPrice: CLPrice
        var isExceedBudget: Bool
        var budgetGap: CLPrice

        init(currentQuotationPrice: CLPrice, budgetPrice: CLPrice) {
            self.currentQuotationPrice = currentQuotationPrice
            self.budgetPrice = budgetPrice
            self.isExceedBudget = (currentQuotationPrice > budgetPrice)
            self.budgetGap = CLPrice(abs(currentQuotationPrice.price - budgetPrice.price))
        }
    }

    enum ViewAction: Equatable {
        case isChangedBudget(newBudgetPrice: CLPrice)
        case isChangedQuotationPrice(newQuotationPrice: CLPrice)
        case isChangedExceedBudget
        case isChangedBudgetGap
    }
}
