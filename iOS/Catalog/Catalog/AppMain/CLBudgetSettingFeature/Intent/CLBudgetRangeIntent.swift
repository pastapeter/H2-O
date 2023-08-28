//
//  CLBudgetRangeIntent.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/06.
//

import Foundation
import Combine

protocol CLBudgetRangeIntentType {
    var viewState: CLBudgetRangeModel.ViewState { get }

    var state: CLBudgetRangeModel.State { get }

    func send(action: CLBudgetRangeModel.ViewAction)

    func send(action: CLBudgetRangeModel.ViewAction, viewEffect: (() -> Void)?)
  
    var quotation: CLBudgetPriceService { get }
}

final class CLBudgetRangeIntent: ObservableObject {
  
  // MARK: - LifeCycle
  init(initialState: ViewState, navigationIntent: AppMainRouteIntentType, quotation: CLBudgetPriceService) {
    viewState = initialState
    self.navigationIntent = navigationIntent
    self.quotation = quotation
  }
  
  // MARK: - Internal
  typealias ViewState = CLBudgetRangeModel.ViewState
  typealias ViewAction = CLBudgetRangeModel.ViewAction
  typealias State = CLBudgetRangeModel.State
  
  @Published var viewState: ViewState = ViewState(currentQuotationPrice: CLNumber(30000000),
                                                  budgetPrice: CLNumber(40000000), status: .default)
  var state: CLBudgetRangeModel.State = .init()
  let navigationIntent: AppMainRouteIntentType
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
      
      viewState.minimumPrice = quotation.minPrice
      viewState.maximumPrice = quotation.maxPrice
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
