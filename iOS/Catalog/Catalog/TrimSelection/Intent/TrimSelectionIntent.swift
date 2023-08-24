//
//  TrimSelectionIntent.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/11.
//

import Foundation
import Combine

protocol TrimSelectionIntentType {

  var viewState: TrimSelectionModel.State { get }

  func send(action: TrimSelectionModel.ViewAction)

  func send(action: TrimSelectionModel.ViewAction, viewEffect: (() -> Void)?)
}

final class TrimSelectionIntent: ObservableObject {

  // MARK: - LifeCycle

  init(initialState: ViewState, repository: TrimSelectionRepositoryProtocol, quotation: Quotation, navigationIntent: CLNavigationIntentType) {
    viewState = initialState
    self.repository = repository
    self.quotation
    self.navigationIntent = navigationIntent
  }

  // MARK: - Internal
  typealias ViewState = TrimSelectionModel.State
  typealias ViewAction = TrimSelectionModel.ViewAction

  private var repository: TrimSelectionRepositoryProtocol
  private var quotation = Quotation.shared
  private var navigationIntent: CLNavigationIntentType
  @Published var viewState: ViewState = ViewState(selectedTrim: nil, carId: 1)

  var cancellable: Set<AnyCancellable> = []
}

extension TrimSelectionIntent: TrimSelectionIntentType, IntentType {

  func mutate(action: TrimSelectionModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
      case .enteredTrimPage:
        Task {
          do {
            let trims = try await repository.fetchTrims(of: viewState.carId)
            self.send(action: .fetchTrims(trims: trims))
          } catch let error {
            viewState.error = error as? TrimSelectionError
          }
        }

      case .fetchTrims(let trims):
        if !trims.isEmpty {
          viewState.trims = trims
          viewState.selectedTrim = trims.first
        } else {
          // TODO: trim Intent Error 만들고 정의하삼
        }
        // 트림 선택할 경우. 트림 id
      case .trimSelected(let index):
      viewState.selectedTrim = viewState.trims[index]

      case .onTapTrimSelectButton:
        guard let trim = viewState.selectedTrim else { return }
        quotation.send(action: .isTrimChanged(trim: trim))
        Task {
          do {
            let defaultQuotation = try await repository.fetchDefaultOptionsByTrim(of: trim)
            let (maxPrice, minPrice) = try await repository.fetchMinMaxPriceByTrim(of: trim.id)
            quotation.send(action: .isTrimSelected(defaultCarQuotation: defaultQuotation,
                                                   minPrice: minPrice,
                                                   maxPrice: maxPrice))
            
            
            viewState.isTrimSelected = true
            navigationIntent.send(action: .onTapNavTab(index: 1))
          } catch let error {
            viewState.error = error as? TrimSelectionError
          }
        }
    }
  }
}
