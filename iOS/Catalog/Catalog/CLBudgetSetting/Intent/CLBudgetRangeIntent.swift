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
  init(initialState: State, navigationIntent: CLNavigationIntentType, quotation: CLBudgetPriceService) {
        state = initialState
    self.navigationIntent = navigationIntent
    self.quotation = quotation
    }

    // MARK: - Internal
    typealias State = CLBudgetRangeModel.State
    typealias ViewAction = CLBudgetRangeModel.ViewAction

    @Published var state: State = State(currentQuotationPrice: CLNumber(30000000),
                                        budgetPrice: CLNumber(40000000), status: .default)
    let navigationIntent: CLNavigationIntentType
    var quotation: CLBudgetPriceService
    var cancellable: Set<AnyCancellable> = []
}

extension CLBudgetRangeIntent: CLBudgetRangeIntentType, IntentType {
    func mutate(action: CLBudgetRangeModel.ViewAction, viewEffect: (() -> Void)?) {
        switch action {
            case .onAppear:
          quotation.totalPricePublisher
            .receive(on: RunLoop.main)
            .sink { [unowned self] totalPrice in
              send(action: .quotationPriceChanged(newQuotationPrice: totalPrice))
            }
            .store(in: &cancellable)
            
            state.minimumPrice = quotation.minPrice
            state.maximumPrice = quotation.maxPrice
            case .budgetChanged(let newBudgetPrice):
                state.budgetPrice = newBudgetPrice
                send(action: .budgetGapChanged)
                send(action: .exceedBudgetChanged)

            case .quotationPriceChanged(let newQuotationPrice):
          
                state.currentQuotationPrice = newQuotationPrice
                send(action: .budgetGapChanged)
                send(action: .exceedBudgetChanged)

            case .exceedBudgetChanged:
                state.isExceedBudget = state.budgetPrice < state.currentQuotationPrice

            case .budgetGapChanged:
                state.budgetGap = CLNumber(abs(state.budgetPrice.value - state.currentQuotationPrice.value))
          case .onTapSimilarQuotationButton:
            navigationIntent.send(action: .onTapSimilarQuotationButton)
        }
    }
}
