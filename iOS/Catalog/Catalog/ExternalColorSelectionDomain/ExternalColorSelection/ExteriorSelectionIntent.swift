//
//  ExternalSelectionIntent.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import Foundation
import Combine

protocol ExteriorSelectionIntentType {

<<<<<<< HEAD
  var viewState: ExteriorSelectionModel.ViewState { get }
  
=======
>>>>>>> dev-ios
  var state: ExteriorSelectionModel.State { get }

  func send(action: ExteriorSelectionModel.ViewAction)

  func send(action: ExteriorSelectionModel.ViewAction, viewEffect: (() -> Void)?)

}

final class ExteriorSelectionIntent: ObservableObject {

<<<<<<< HEAD
  init(initialState: State, initialViewState: ViewState, repository: ExteriorColorRepositoryProtocol) {
    viewState = initialViewState
=======
  init(initialState: State, repository: ExteriorColorRepositoryProtocol) {
>>>>>>> dev-ios
    state = initialState
    self.repository = repository
  }

  private var repository: ExteriorColorRepositoryProtocol

<<<<<<< HEAD
  typealias ViewState = ExteriorSelectionModel.ViewState
  typealias State = ExteriorSelectionModel.State
  typealias ViewAction = ExteriorSelectionModel.ViewAction

  @Published var viewState: ViewState
  var state: State
=======
  typealias State = ExteriorSelectionModel.State

  typealias ViewAction = ExteriorSelectionModel.ViewAction

  @Published var state: State
>>>>>>> dev-ios

  var cancellable: Set<AnyCancellable> = []

}

extension ExteriorSelectionIntent: ExteriorSelectionIntentType, IntentType {

  func mutate(action: ExteriorSelectionModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
    case .onAppear:
      Task {
        do {
<<<<<<< HEAD
          let externalColors = try await repository.fetch(with: viewState.selectedTrimId)
=======
          let externalColors = try await repository.fetch(with: state.selectedTrimId)
>>>>>>> dev-ios
          send(action: .fetchColors(colors: externalColors))
        } catch let _ {
          // TODO: Error Handling
        }
      }
    case .fetchColors(let colors):
      let colorStates = colors.map { ExteriorColorState(isSelected: false, color: $0) }
<<<<<<< HEAD
      viewState.colors = colorStates
=======
      state.colors = colorStates
>>>>>>> dev-ios
      if !colorStates.isEmpty {
        send(action: .onTapColor(id: colorStates[0].color.id))
        // TODO:
      }
    case .changeSelectedExternalImageURL:
      print("External Image Urls")
    case .onTapColor(let id):
<<<<<<< HEAD
      viewState.selectedColorId = id
      for i in viewState.colors.indices {
        if viewState.colors[i].color.id == id {
          viewState.colors[i].isSelected = true
          send(action: .changeSelectedExternalImageURL(url: []))
        } else {
          viewState.colors[i].isSelected = false
=======
      state.selectedColorId = id
      for i in state.colors.indices {
        if state.colors[i].color.id == id {
          state.colors[i].isSelected = true
          send(action: .changeSelectedExternalImageURL(url: []))
        } else {
          state.colors[i].isSelected = false
>>>>>>> dev-ios
        }
      }
    }
  }

}
