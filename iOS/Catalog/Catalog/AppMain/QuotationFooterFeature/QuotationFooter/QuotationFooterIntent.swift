//
//  QuotationFooterIntent.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/24.
//

import Foundation
import Combine
import SwiftUI

protocol QuotationFooterIntentType {
  
  var state: QuotationFooterModel.State { get }
  var viewState: QuotationFooterModel.ViewState { get }
  
  func send(action: QuotationFooterModel.ViewAction)
  
  func send(action: QuotationFooterModel.ViewAction, viewEffect: (() -> Void)?)
  
  var quotation: QuotationFooterService { get }
}

final class QuotationFooterIntent: ObservableObject {
  
  init(initialViewState: ViewState, initialState: State, repository: QuotationFooterRepositoryProtocol , quotation: QuotationFooterService) {
    state = initialState
    
    self.repository = repository
    self.quotation = quotation
  }
  
  typealias State = QuotationFooterModel.State
  typealias ViewState = QuotationFooterModel.ViewState
  typealias ViewAction = QuotationFooterModel.ViewAction
  
  @Published var viewState: ViewState = .init(totalPrice: CLNumber(0), summary: SummaryCarQuotation.mock())
  var state: QuotationFooterModel.State = .init()
  
  var cancellable: Set<AnyCancellable> = []
  
  private var repository: QuotationFooterRepositoryProtocol
  
  var quotation: QuotationFooterService
  
}

extension QuotationFooterIntent: QuotationFooterIntentType, IntentType {
  func mutate(action: QuotationFooterModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
      case .priceChanged(let price):
      viewState.totalPrice = price
        return
      case .summaryChanged:
      viewState.summary = quotation.summaryQuotation()
      case .onAppear:
      quotation.totalPricePublisher
        .receive(on: RunLoop.main)
        .sink { [unowned self] totalPrice in
          self.send(action: .priceChanged(price: totalPrice))
        }
        .store(in: &cancellable)
      case .onTapCompleteButton:
        Task {
          do {
            let quotationId = try await repository.saveFinalQuotation(with: quotation.quotationInQuotationFooter())
          } catch let error {
            print(error.localizedDescription)
          }
        }
    }
  }
}



