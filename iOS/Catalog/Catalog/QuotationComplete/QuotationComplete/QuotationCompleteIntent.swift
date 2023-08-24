//
//  QuotationCompleteIntent.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/21.
//

import Foundation
import Combine

protocol QuotationCompleteIntentType {
  
  var viewState: QuotationCompleteModel.State { get }
  
  func send(action: QuotationCompleteModel.ViewAction)
  
  func send(action: QuotationCompleteModel.ViewAction, viewEffect: (() -> Void)?)
  
  var repository: QuotationCompleteRepositoryProtocol { get }
  var quotationService: QuotationCompleteService { get }
  
}

final class QuotationCompleteIntent: ObservableObject {
  
  init(initialState: ViewState, repository: QuotationCompleteRepositoryProtocol, quotationService: QuotationCompleteService, navigationIntent: CLNavigationIntentType) {
    viewState = initialState
    self.repository = repository
    self.quotationService = quotationService
    self.navigationIntent = navigationIntent
  }
  
  typealias ViewState = QuotationCompleteModel.State
  typealias ViewAction = QuotationCompleteModel.ViewAction
  
  @Published var viewState: ViewState
  
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
            viewState.technicalSpec = resultOfCalculation
          } catch(let e) {
            print("@@@@배기량 계산 실패 \(e)")
          }
        }
        viewState.summaryQuotation = Quotation.shared.getSummary()
        
      case .onTapDeleteButton(let id):
        viewState.alertCase = .delete(id: id)
        send(action: .showAlertChanged(showAlert: true))
        
      case .onTapModifyButton(let navigationIndex, let title):
        viewState.alertCase = .modify(index: navigationIndex, title: title)
        send(action: .showAlertChanged(showAlert: true))

      case .movePage(let index):
        send(action: .showAlertChanged(showAlert: false))
        send(action: .showSheetChanged(showSheet: false))
        navigationIntent.send(action: .onTapNavTab(index: index))
        
      case .deleteOption(let option):
        // 옵션삭제 로직
        Quotation.shared.send(action: .similarOptionsDeleted(option: option))
        send(action: .onAppear)
        send(action: .showAlertChanged(showAlert: false))

      case .showSheetChanged(let showSheet):
        viewState.showSheet = showSheet
      case .showAlertChanged(let showAlert):
        viewState.showAlert = showAlert
    }
  }
}
