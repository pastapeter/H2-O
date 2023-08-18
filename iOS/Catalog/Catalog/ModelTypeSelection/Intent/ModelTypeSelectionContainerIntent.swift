//
//  ModelTypeSelectionContainerIntent.swift
//  Catalog
//
//  Created by Jung peter on 8/14/23.
//

import Foundation
import Combine

protocol ModelTypeSelectionContainerIntentType {

  var state: ModelTypeSelectionContainerModel.State { get }

  func send(action: ModelTypeSelectionContainerModel.ViewAction)

  func send(action: ModelTypeSelectionContainerModel.ViewAction, viewEffect: (() -> Void)?)

}

final class ModelTypeSelectionContainerIntent: ObservableObject {

  init(initialState: State, repository: ModelTypeRepositoryProtocol) {
    state = initialState
    self.repository = repository
  }

  private var repository: ModelTypeRepositoryProtocol

  typealias State = ModelTypeSelectionContainerModel.State

  typealias ViewAction = ModelTypeSelectionContainerModel.ViewAction

  @Published var state: State

  var cancellable: Set<AnyCancellable> = []
}

extension ModelTypeSelectionContainerIntent: ModelTypeSelectionContainerIntentType, IntentType {

  func mutate(action: ModelTypeSelectionContainerModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
    case .onAppear:
      Task {
        let options = try await repository.fetch(carId: state.selectedTrimId)
        send(action: .modelTypeOptions(options: options))
      }
    case .calculateFuelEfficiency:
      return
    case .modelTypeOptions(let options):
      state.modelTypeStateArray = options.map({
        ModelTypeModel.State.init(title: $0.title,
                                  optionStates: $0.options,
                                  modelTypeDetailState: [.init(content: .mock(), hmgData: .mock()), .init(content: .mock(), hmgData: .mock())])
      })
    }
  }

}
