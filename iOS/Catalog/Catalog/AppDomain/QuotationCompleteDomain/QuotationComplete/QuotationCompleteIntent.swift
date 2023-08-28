//
//  QuotationCompleteIntent.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/21.
//

import Foundation
import Combine

protocol QuotationCompleteIntentType {
  
  var viewState: QuotationCompleteModel.ViewState { get }
  
  var state: QuotationCompleteModel.State { get }
  
  func send(action: QuotationCompleteModel.ViewAction)
  
  func send(action: QuotationCompleteModel.ViewAction, viewEffect: (() -> Void)?)
  
  var repository: QuotationCompleteRepositoryProtocol { get }
  
  var quotation: QuotationCompleteService { get }
  
}

final class QuotationCompleteIntent: ObservableObject {
  
  init(initialState: ViewState, repository: QuotationCompleteRepositoryProtocol, quotation: QuotationCompleteService, navigationIntent: AppMainRouteIntentType) {
    viewState = initialState
    self.repository = repository
    self.quotation = quotation
    self.navigationIntent = navigationIntent
  }
  
  typealias ViewState = QuotationCompleteModel.ViewState
  typealias State = QuotationCompleteModel.State
  typealias ViewAction = QuotationCompleteModel.ViewAction
  
  @Published var viewState: ViewState
  var state: QuotationCompleteModel.State = .init()
  
  var cancellable: Set<AnyCancellable> = []
  var navigationIntent: AppMainRouteIntentType
  private(set) var repository: QuotationCompleteRepositoryProtocol
  private(set) var quotation: QuotationCompleteService
  
}

extension QuotationCompleteIntent: QuotationCompleteIntentType, IntentType {
  
  
  func mutate(action: QuotationCompleteModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
      case .onAppear:
        Task {
          do {
            let powertrainId = quotation.powertrainId()
            let drivetrainId = quotation.drivetrainId()
            let resultOfCalculation = try await repository.calculateFuelAndDisplacement(with: powertrainId, andwith: drivetrainId)
            viewState.technicalSpec = resultOfCalculation
          } catch(let e) {
            print("@@@@배기량 계산 실패 \(e)")
          }
        }
        viewState.summaryQuotation = quotation.summary()
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
        quotation.deleteSimilarOption(id: option)
        send(action: .onAppear)
        send(action: .showAlertChanged(showAlert: false))

      case .showSheetChanged(let showSheet):
        if showSheet == true {
          viewState.summaryQuotation = quotation.summary()
        }
        viewState.showSheet = showSheet
        
      case .showAlertChanged(let showAlert):
        viewState.showAlert = showAlert
    }
  }
}
