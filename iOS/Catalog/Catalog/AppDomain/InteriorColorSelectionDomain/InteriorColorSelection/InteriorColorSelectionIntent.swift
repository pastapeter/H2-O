//
//  InteriorColorSelectionIntent.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import Foundation
import Combine

protocol InteriorColorSelectionIntentType {

  var viewState: InteriorColorSelectionModel.State { get }

  func send(action: InteriorColorSelectionModel.ViewAction)

  func send(action: InteriorColorSelectionModel.ViewAction, viewEffect: (() -> Void)?)

}

final class InteriorColorSelectionIntent: ObservableObject {

  init(initialState: ViewState, repository: InteriorColorSelectionRepositoryProtocol, quotation: InteriorSelectionService) {
    viewState = initialState
    self.repository = repository
    self.quotation = quotation
  }

  private var repository: InteriorColorSelectionRepositoryProtocol

  typealias ViewState = InteriorColorSelectionModel.State

  typealias ViewAction = InteriorColorSelectionModel.ViewAction

  @Published var viewState: ViewState

  var cancellable: Set<AnyCancellable> = []
  
  private var quotation: InteriorSelectionService

}

extension InteriorColorSelectionIntent: InteriorColorSelectionIntentType, IntentType {


  func mutate(action: InteriorColorSelectionModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
    case .onAppear:
      Task {
        do {
          let colors = try await self.repository.fetch(with: viewState.selectedTrimID)
          send(action: .trimColors(colors: colors))
        } catch {

        }
      }
    case .trimColors(let colors):
      let colorStates = colors.map { InteriorColorState(isSelected: false, color: $0) }
      self.viewState.trimColors = colorStates
      if !colorStates.isEmpty {
        send(action: .onTapColor(id: colorStates[0].color.id))
      }
    case .changeSelectedInteriorImageURL(let url):
      viewState.selectedInteriorImageURL = url
    case .onTapColor(let id):
<<<<<<< HEAD:iOS/Catalog/Catalog/InteriorColorSelectionDomain/InteriorColorSelection/InteriorColorSelectionIntent.swift
      viewState.selectedColorId = id
      for i in viewState.trimColors.indices {
        if viewState.trimColors[i].color.id == id {
          viewState.trimColors[i].isSelected = true
          send(action: .changeSelectedInteriorImageURL(url: viewState.trimColors[i].color.bannerImageURL))
=======
      state.selectedColorId = id
      quotation.updateInteriorColor(to: state.trimColors.first(where: { $0.color.id == id })?.color)
      for i in state.trimColors.indices {
        if state.trimColors[i].color.id == id {
          state.trimColors[i].isSelected = true
          send(action: .changeSelectedInteriorImageURL(url: state.trimColors[i].color.bannerImageURL))
>>>>>>> dev-ios:iOS/Catalog/Catalog/AppDomain/InteriorColorSelectionDomain/InteriorColorSelection/InteriorColorSelectionIntent.swift
        } else {
          viewState.trimColors[i].isSelected = false
        }
      }
    }
  }

}