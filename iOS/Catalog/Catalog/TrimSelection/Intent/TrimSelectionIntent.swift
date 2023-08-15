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

  init(initialState: State, repository: TrimSelectionRepositoryProtocol) {
    state = initialState
    self.repository = repository
  }
  // MARK: - Internal
  typealias State = TrimSelectionModel.State
  typealias ViewAction = TrimSelectionModel.ViewAction

  private var repository: TrimSelectionRepositoryProtocol

  @Published var state: State = State(selectedTrim: nil, vehicleId: 123)

  var cancellable: Set<AnyCancellable> = []
}

extension TrimSelectionIntent: TrimSelectionIntentType, IntentType {

  func mutate(action: TrimSelectionModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {

      case .enteredTrimPage:
        Task {
          do {
            let trims = try await repository.fetchTrims(in: state.vehicleId)
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

      case .onTapTrimSelectButton: break

      case .trimSelected(let index):
        state.selectedTrim = state.trims[index]
    }
  }
}
