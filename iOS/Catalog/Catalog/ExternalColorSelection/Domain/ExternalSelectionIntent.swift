//
//  ExternalSelectionIntent.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import Foundation
import Combine

protocol ExternalSelectionIntentType {

  var state: ExternalSelectionModel.State { get }

  func send(action: ExternalSelectionModel.ViewAction)

  func send(action: ExternalSelectionModel.ViewAction, viewEffect: (() -> Void)?)

}

final class ExternalSelectionIntent: ObservableObject {

  init(initialState: State, repository: ExternalColorRepositoryProtocol) {
    state = initialState
    self.repository = repository
  }

  private var repository: ExternalColorRepositoryProtocol

  typealias State = ExternalSelectionModel.State

  typealias ViewAction = ExternalSelectionModel.ViewAction

  @Published var state: State

  var cancellable: Set<AnyCancellable> = []

}

extension ExternalSelectionIntent: ExternalSelectionIntentType, IntentType {

  func mutate(action: ExternalSelectionModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
    case .onAppear:
      Task {
        do {
          let externalColors = try await repository.fetch(with: state.selectedTrimId)
          send(action: .fetchColors(colors: externalColors))
        } catch let error {
          // TODO: Error Handling
        }
      }
    case .fetchColors(let colors):
      var colorStates = colors.map { ColorState(isSelected: false, color: $0) }
      colorStates[0].isSelected = true
      state.colors = colorStates
    }
  }

}
