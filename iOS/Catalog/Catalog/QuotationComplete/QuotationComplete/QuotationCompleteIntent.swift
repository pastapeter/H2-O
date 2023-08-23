//
//  QuotationCompleteIntent.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/21.
//

import Foundation
import Combine

protocol QuotationCompleteIntentType {

  var state: QuotationCompleteModel.State { get }

  func send(action: QuotationCompleteModel.ViewAction)

  func send(action: QuotationCompleteModel.ViewAction, viewEffect: (() -> Void)?)
  
  var repository: QuotationCompleteRepositoryProtocol { get }
  var quotationService: QuotationCompleteService { get }
  
}

final class QuotationCompleteIntent: ObservableObject {

  init(initialState: State, repository: QuotationCompleteRepositoryProtocol, quotationService: QuotationCompleteService, navigationIntent: CLNavigationIntentType) {
    state = initialState
    self.repository = repository
    self.quotationService = quotationService
    self.navigationIntent = navigationIntent
  }

  typealias State = QuotationCompleteModel.State
  typealias ViewAction = QuotationCompleteModel.ViewAction

  @Published var state: State

  var cancellable: Set<AnyCancellable> = []
  var quotationService: QuotationCompleteService
  var navigationIntent: CLNavigationIntentType
  private(set) var repository: QuotationCompleteRepositoryProtocol
}

extension QuotationCompleteIntent: QuotationCompleteIntentType, IntentType {


  func mutate(action: QuotationCompleteModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
      case .onAppear:
        Task {
          do {
            let ids = try quotationService.getPowertrainAndDriveTrain()
            let resultOfCalculation = try await repository.calculateFuelAndDisplacement(with: ids.0, andwith: ids.1)
            state.technicalSpec = resultOfCalculation
          } catch(let e) {
            print("@@@@배기량 계산 실패 \(e)")
          }
        }
        state.summaryQuotation = Quotation.shared.getSummary()
      case .onTapDeleteButton: return
      case .onTapModifyButton(let index): return
        navigationIntent.send(action: .onTapNavTab(index: index))
    }
  }
}
