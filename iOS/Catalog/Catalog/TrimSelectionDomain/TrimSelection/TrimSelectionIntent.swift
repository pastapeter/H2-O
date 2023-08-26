//
//  TrimSelectionIntent.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/11.
//

import Foundation
import Combine

protocol TrimSelectionIntentType {

  var state: TrimSelectionModel.State { get }

  func send(action: TrimSelectionModel.ViewAction)

  func send(action: TrimSelectionModel.ViewAction, viewEffect: (() -> Void)?)
}

final class TrimSelectionIntent: ObservableObject {

  // MARK: - LifeCycle

  init(initialState: State, repository: TrimSelectionRepositoryProtocol, quotation: TrimSelectionService, navigationIntent: CLNavigationIntentType) {
    state = initialState
    self.repository = repository
    self.quotation = quotation
    self.navigationIntent = navigationIntent
  }

  // MARK: - Internal
  typealias State = TrimSelectionModel.State
  typealias ViewAction = TrimSelectionModel.ViewAction

  private var repository: TrimSelectionRepositoryProtocol
  private var quotation: TrimSelectionService
  private var navigationIntent: CLNavigationIntentType
  @Published var state: State = State(selectedTrim: Trim(id: 0, name: "", description: "", price: CLNumber(0), hmgData: []), carId: 1)

  var cancellable: Set<AnyCancellable> = []
}

extension TrimSelectionIntent: TrimSelectionIntentType, IntentType {

  func mutate(action: TrimSelectionModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
      case .enteredTrimPage:
        Task {
          do {
            let trims = try await repository.fetchTrims(of: state.carId)
            self.send(action: .fetchTrims(trims: trims))
          } catch let error {
            state.error = error as? TrimSelectionError
          }
        }

      case .fetchTrims(let trims):
        if !trims.isEmpty {
          state.trims = trims
          state.selectedTrim = trims.first
        } else {
          // TODO: trim Intent Error 만들고 정의하삼
        }
        // 트림 선택할 경우. 트림 id
      case .trimSelected(let index):
        state.selectedTrim = state.trims[index]

      case .onTapTrimSelectButton:
        guard let trim = state.selectedTrim else { return }
        Task {
          do {
            let defaultQuotation = try await repository.fetchDefaultOptionsByTrim(of: trim)
            let (maxPrice, minPrice) = try await repository.fetchMinMaxPriceByTrim(of: trim.id)
            quotation.saveDefaultQuotation(trim: trim, carQuotation: defaultQuotation, minPrice: minPrice, maxPrice: maxPrice)
            state.isTrimSelected = true
            navigationIntent.send(action: .onTapNavTab(index: 1))
          } catch let error {
            state.error = error as? TrimSelectionError
          }
        }
    }
  }
}
