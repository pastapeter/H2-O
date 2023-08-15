//
//  InteriorColorSelectionIntent.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import Foundation
import Combine

protocol InteriorColorSelectionIntentType {

  var state: InteriorColorSelectionModel.State { get }

  func send(action: InteriorColorSelectionModel.ViewAction)

  func send(action: InteriorColorSelectionModel.ViewAction, viewEffect: (() -> Void)?)

}

final class InteriorColorSelectionIntent: ObservableObject {

  init(initialState: State, repository: InteriorColorSelectionRepositoryProtocol) {
    state = initialState
    self.repository = repository
  }

  private var repository: InteriorColorSelectionRepositoryProtocol

  typealias State = InteriorColorSelectionModel.State

  typealias ViewAction = InteriorColorSelectionModel.ViewAction

  @Published var state: State

  var cancellable: Set<AnyCancellable> = []

}

extension InteriorColorSelectionIntent: InteriorColorSelectionIntentType, IntentType {

  func mutate(action: InteriorColorSelectionModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
    case .onAppear:
      Task {
        do {
          let colors = try await self.repository.fetch(with: state.selectedTrimID)
          send(action: .trimColors(colors: colors))
        } catch {

        }
      }
    case .trimColors(let colors):
      let colorStates = colors.map { InteriorColorState(isSelected: false, color: $0) }
      self.state.trimColors = colorStates
      if !colorStates.isEmpty {
        send(action: .onTapColor(id: colorStates[0].color.id))
      }
    case .changeSelectedInteriorImageURL:
      print("새롭게 받은 URL")
    case .onTapColor(let id):
      state.selectedColorId = id
      for i in state.trimColors.indices {
        if state.trimColors[i].color.id == id {
          state.trimColors[i].isSelected = true
          send(action: .changeSelectedInteriorImageURL(url: state.trimColors[i].color.bannerImageURL))
        } else {
          state.trimColors[i].isSelected = false
        }
      }
    }
  }

}
