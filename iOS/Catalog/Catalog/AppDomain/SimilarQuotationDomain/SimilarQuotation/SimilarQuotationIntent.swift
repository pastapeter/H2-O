//
//  SimilarQuotationIntent.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/19.
//

import Foundation
import Combine

protocol SimilarQuotationIntentType {
  
  var viewState: SimilarQuotationModel.ViewState { get }
  
  var state: SimilarQuotationModel.State { get }
  
  func send(action: SimilarQuotationModel.ViewAction, viewEffect: (() -> Void)?)
  
  func send(action: SimilarQuotationModel.ViewAction)
  
  var quotation: SimilarQuotationService { get }
}

final class SimilarQuotationIntent: ObservableObject {
  
  init(initialState: ViewState, repository: SimilarQuotationRepositoryProtocol, navigationIntent: AppMainRouteIntentType, budgetRangeIntent: CLBudgetRangeIntentType, quotation: SimilarQuotationService) {
    viewState = initialState
    self.repository = repository
    self.navigationIntent = navigationIntent
    self.budgetRangeIntent = budgetRangeIntent
    self.quotation = quotation
  }
  
  typealias ViewState = SimilarQuotationModel.ViewState
  typealias State = SimilarQuotationModel.State
  typealias ViewAction = SimilarQuotationModel.ViewAction
  
  @Published var viewState: ViewState = .init(currentSimilarQuotationIndex: 0,
                                      similarQuotations: [.mock(), .mock(), .mock()],
                                      selectedOptions: [],
                                      alertCase: .noOption,
                                      showAlert: false)
  var state: SimilarQuotationModel.State = .init()
  var cancellable: Set<AnyCancellable> = []
  private var repository: SimilarQuotationRepositoryProtocol
  private var navigationIntent: AppMainRouteIntentType
  private var budgetRangeIntent: CLBudgetRangeIntentType
  private(set) var quotation: SimilarQuotationService
}

extension SimilarQuotationIntent: SimilarQuotationIntentType, IntentType {
  
  func mutate(action: SimilarQuotationModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
      case .onAppear(let carQuotation):
        Task {
          do {
            let similarQuotations = try await repository.fetchSimilarQuotation(quotation: carQuotation)
            viewState.similarQuotations = similarQuotations
          } catch(let e) {
            print(String(describing: e))
          }
        }
        
      case .onTapBackButton:
        if viewState.selectedOptions.isEmpty {
          viewState.alertCase = .noOption
        } else {
          viewState.alertCase = .optionButQuit
        }
        
      case .onTapAddButton(let title, let count):
        viewState.alertCase = .addOption(title: title, count: count)
        send(action: .showAlertChanged(showAlert: true))
        
      case .onTapHelpButton:
        viewState.alertCase = .help
        send(action: .showAlertChanged(showAlert: true))
        
      case .optionSelected(let selectedOption):
        if viewState.selectedOptions.contains(selectedOption) {
          viewState.selectedOptions = viewState.selectedOptions.filter { $0 != selectedOption }
          quotation.addSimilarOption(options: viewState.selectedOptions)
        } else {
          viewState.selectedOptions.append(selectedOption)
          quotation.addSimilarOption(options: viewState.selectedOptions)
        }
        
      case .currentSimilarQuotationIndexChanged(let index):
        viewState.currentSimilarQuotationIndex = index
        budgetRangeIntent.send(action: .budgetChanged(newBudgetPrice: viewState.similarQuotations[index].price))
        
      case .choiceQuit:
        send(action: .showAlertChanged(showAlert: false))
        navigationIntent.send(action: .onTapSimilarQuotationBackButton)
        viewState.selectedOptions = []
        
      case .choiceAdd:
        quotation.addSimilarOption(options: viewState.selectedOptions)
        send(action: .choiceQuit)
      case .showAlertChanged(let showAlert):
        viewState.showAlert = showAlert
    }
  }
}
