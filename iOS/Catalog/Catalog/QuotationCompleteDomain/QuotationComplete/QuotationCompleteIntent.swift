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
  
  var quotation: QuotationCompleteService { get }
  
}

final class QuotationCompleteIntent: ObservableObject {
  
  init(initialState: State, repository: QuotationCompleteRepositoryProtocol, quotation: QuotationCompleteService, navigationIntent: CLNavigationIntentType) {
    state = initialState
    self.repository = repository
    self.quotation = quotation
    self.navigationIntent = navigationIntent
  }
  
  typealias State = QuotationCompleteModel.State
  typealias ViewAction = QuotationCompleteModel.ViewAction
  
  @Published var state: State
  
  var cancellable: Set<AnyCancellable> = []
  var navigationIntent: CLNavigationIntentType
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
            state.technicalSpec = resultOfCalculation
          } catch(let e) {
            print("@@@@배기량 계산 실패 \(e)")
          }
        }
        state.summaryQuotation = quotation.summary()
        
      case .onTapDeleteButton(let id):
        state.alertCase = .delete(id: id)
        send(action: .showAlertChanged(showAlert: true))
        
      case .onTapModifyButton(let navigationIndex, let title):
        state.alertCase = .modify(index: navigationIndex, title: title)
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
        state.showSheet = showSheet
      case .showAlertChanged(let showAlert):
        state.showAlert = showAlert
    }
  }
}
