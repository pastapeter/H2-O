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
  
  func send(action: QuotationFooterModel.ViewAction)
  
  func send(action: QuotationFooterModel.ViewAction, viewEffect: (() -> Void)?)
  
  var quotation: QuotationFooterService { get }
}

final class QuotationFooterIntent: ObservableObject {
  
  init(initialState: State, repository: QuotationFooterRepositoryProtocol , quotation: QuotationFooterService) {
    state = initialState
    self.repository = repository
    self.quotation = quotation
  }
  
  typealias State = QuotationFooterModel.State
  typealias ViewAction = QuotationFooterModel.ViewAction
  
  @Published var state: State = .init(totalPrice: CLNumber(0), summary: SummaryCarQuotation.mock())
  
  var cancellable: Set<AnyCancellable> = []
  
  private var repository: QuotationFooterRepositoryProtocol
  
  var quotation: QuotationFooterService
  
}

extension QuotationFooterIntent: QuotationFooterIntentType, IntentType {
  func mutate(action: QuotationFooterModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
      case .priceChanged(let price):
        state.totalPrice = quotation.totalPrice
      case .summaryChanged:
        state.summary = quotation.summaryQuotation()
      case .showSheet(_):
        return
      case .onAppear:
        return
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



