//
//  CLBudgetRangeIntent.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/06.
//

import Foundation
import Combine

protocol CLBudgetRangeIntentType {

    var state: CLBudgetRangeModel.State { get }

    func send(action: CLBudgetRangeModel.ViewAction)

    func send(action: CLBudgetRangeModel.ViewAction, viewEffect: (() -> Void)?)

}

final class CLBudgetRangeIntent: ObservableObject {

    // MARK: - LifeCycle
    init(initialState: State) {
        state = initialState
    }

    // MARK: - Internal
    typealias State = CLBudgetRangeModel.State
    typealias ViewAction = CLBudgetRangeModel.ViewAction

    @Published var state: State = State(currentQuotationPrice: CLNumber(30000000),
                                        budgetPrice: CLNumber(40000000))
    var quotation = Quotation.shared
    var cancellable: Set<AnyCancellable> = []
}

extension CLBudgetRangeIntent: CLBudgetRangeIntentType, IntentType {
    func mutate(action: CLBudgetRangeModel.ViewAction, viewEffect: (() -> Void)?) {
        switch action {
            case .onAppear:
            state.currentQuotationPrice = quotation.state.totalPrice
            print(quotation.state.minPrice, quotation.state.maxPrice)
            state.minimumPrice = quotation.state.minPrice
            state.maximumPrice = quotation.state.maxPrice
            case .isChangedBudget(let newBudgetPrice):
                state.budgetPrice = newBudgetPrice
                send(action: .isChangedBudgetGap)
                send(action: .isChangedExceedBudget)

            case .isChangedQuotationPrice(let newQuotationPrice):
                state.currentQuotationPrice = newQuotationPrice
                send(action: .isChangedBudgetGap)
                send(action: .isChangedExceedBudget)

            case .isChangedExceedBudget:
                state.isExceedBudget = state.budgetPrice < state.currentQuotationPrice

            case .isChangedBudgetGap:
                state.budgetGap = CLNumber(abs(state.budgetPrice.value - state.currentQuotationPrice.value))
            default: return
        }
    }
}
