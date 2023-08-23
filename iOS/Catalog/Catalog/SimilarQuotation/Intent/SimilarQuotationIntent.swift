//
//  SimilarQuotationIntent.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/19.
//

import Foundation
import Combine

protocol SimilarQuotationIntentType {
  
  var state: SimilarQuotationModel.State { get }
  
  func send(action: SimilarQuotationModel.ViewAction, viewEffect: (() -> Void)?)
  
  func send(action: SimilarQuotationModel.ViewAction)
  
}

final class SimilarQuotationIntent: ObservableObject {
  
  init(initialState: State, repository: SimilarQuotationRepositoryProtocol, navigationIntent: CLNavigationIntentType, budgetRangeIntent: CLBudgetRangeIntentType) {
    state = initialState
    self.repository = repository
    self.navigationIntent = navigationIntent
    self.budgetRangeIntent = budgetRangeIntent
  }
  
  typealias State = SimilarQuotationModel.State
  
  typealias ViewAction = SimilarQuotationModel.ViewAction
  
  @Published var state: State = .init(currentSimilarQuotationIndex: 0,
                                      similarQuotations: [.mock(), .mock(), .mock()],
                                      selectedOptions: [])
  
  var cancellable: Set<AnyCancellable> = []
  private var repository: SimilarQuotationRepositoryProtocol
  private var navigationIntent: CLNavigationIntentType
  private var budgetRangeIntent: CLBudgetRangeIntentType
}

extension SimilarQuotationIntent: SimilarQuotationIntentType, IntentType {
  
  func mutate(action: SimilarQuotationModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
      case .onAppear(let quotation):
        Task {
          do {
            let similarQuotations = try await repository.fetchSimilarQuotation(quotation: quotation)
            state.similarQuotations = similarQuotations
          } catch(let e) {
            print(String(describing: e))
          }
        }
      case .onTapBackButton:
        navigationIntent.send(action: .onTapSimilarQuotationBackButton)
        print("뒤로가기 버튼 클릭")
      case .onTapAddButton:
        Quotation.shared.send(action: .similarOptionsAdded(option: state.selectedOptions))
        send(action: .onTapBackButton)
        print("추가하기 버튼 클릭")

      case .optionSelected(let selectedOption):
        if state.selectedOptions.contains(selectedOption) {
          state.selectedOptions = state.selectedOptions.filter { $0 != selectedOption }
        } else {
          state.selectedOptions.append(selectedOption)
        }
        
      case .currentSimilarQuotationIndexChanged(let index):
        state.currentSimilarQuotationIndex = index
        budgetRangeIntent.send(action: .budgetChanged(newBudgetPrice: state.similarQuotations[index].price))
    }
  }
}
