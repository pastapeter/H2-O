//
//  ExternalSelectionIntent.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import Foundation
import Combine

protocol ExteriorSelectionIntentType {

  var state: ExteriorSelectionModel.State { get }

  func send(action: ExteriorSelectionModel.ViewAction)

  func send(action: ExteriorSelectionModel.ViewAction, viewEffect: (() -> Void)?)

}

final class ExteriorSelectionIntent: ObservableObject {

  init(initialState: State, repository: ExteriorColorRepositoryProtocol) {
    state = initialState
    self.repository = repository
  }

  private var repository: ExteriorColorRepositoryProtocol

  typealias State = ExteriorSelectionModel.State

  typealias ViewAction = ExteriorSelectionModel.ViewAction

  @Published var state: State

  var cancellable: Set<AnyCancellable> = []

}

extension ExteriorSelectionIntent: ExteriorSelectionIntentType, IntentType {

  func mutate(action: ExteriorSelectionModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
    case .onAppear:
      Task {
        do {
          let externalColors = try await repository.fetch(with: state.selectedTrimId)
          send(action: .fetchColors(colors: externalColors))
        } catch let _ {
          // TODO: Error Handling
        }
      }
    case .fetchColors(let colors):
      let colorStates = colors.map { ExteriorColorState(isSelected: false, color: $0) }
      state.colors = colorStates
      if !colorStates.isEmpty {
        send(action: .onTapColor(id: colorStates[0].color.id))
        // TODO:
      }
    case .changeSelectedExternalImageURL:
      print("External Image Urls")
    case .onTapColor(let id):
      state.selectedColorId = id
      for i in state.colors.indices {
        if state.colors[i].color.id == id {
          state.colors[i].isSelected = true
          send(action: .changeSelectedExternalImageURL(url: []))
        } else {
          state.colors[i].isSelected = false
        }
      }
    }
  }

}
