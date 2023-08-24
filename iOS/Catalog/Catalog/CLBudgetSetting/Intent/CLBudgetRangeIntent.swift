//
//  CLBudgetRangeIntent.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/06.
//

import Foundation
import Combine

protocol CLBudgetRangeIntentType {

    var viewState: CLBudgetRangeModel.State { get }

    func send(action: CLBudgetRangeModel.ViewAction)

    func send(action: CLBudgetRangeModel.ViewAction, viewEffect: (() -> Void)?)

}

final class CLBudgetRangeIntent: ObservableObject {

    // MARK: - LifeCycle
  init(initialState: ViewState, navigationIntent: CLNavigationIntentType) {
        viewState = initialState
    self.navigationIntent = navigationIntent
    }

    // MARK: - Internal
    typealias ViewState = CLBudgetRangeModel.State
    typealias ViewAction = CLBudgetRangeModel.ViewAction

    @Published var viewState: ViewState = ViewState(currentQuotationPrice: CLNumber(30000000),
                                        budgetPrice: CLNumber(40000000), status: .default)
    let navigationIntent: CLNavigationIntentType
    var quotation = Quotation.shared
    var cancellable: Set<AnyCancellable> = []
}

extension CLBudgetRangeIntent: CLBudgetRangeIntentType, IntentType {
    func mutate(action: CLBudgetRangeModel.ViewAction, viewEffect: (() -> Void)?) {
        switch action {
            case .onAppear:
            viewState.currentQuotationPrice = quotation.viewState.totalPrice
            print(quotation.viewState.minPrice, quotation.viewState.maxPrice)
            viewState.minimumPrice = quotation.viewState.minPrice
            viewState.maximumPrice = quotation.viewState.maxPrice
            case .budgetChanged(let newBudgetPrice):
                viewState.budgetPrice = newBudgetPrice
                send(action: .budgetGapChanged)
                send(action: .exceedBudgetChanged)

            case .quotationPriceChanged(let newQuotationPrice):
                viewState.currentQuotationPrice = newQuotationPrice
                send(action: .budgetGapChanged)
                send(action: .exceedBudgetChanged)

            case .exceedBudgetChanged:
                viewState.isExceedBudget = viewState.budgetPrice < viewState.currentQuotationPrice

            case .budgetGapChanged:
                viewState.budgetGap = CLNumber(abs(viewState.budgetPrice.value - viewState.currentQuotationPrice.value))
          case .onTapSimilarQuotationButton:
            navigationIntent.send(action: .onTapSimilarQuotationButton)
        }
    }
}
