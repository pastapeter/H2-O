//
//  NavigationIndent.swift
//  Catalog
//
//  Created by Jung peter on 8/3/23.
//

import Foundation
import Combine

final class CLNavigationIntent: ObservableObject {

  // MARK: - LifeCycle

  init(initialState: State) {
    state = initialState
  }

  // MARK: - Internal

  @Published var state: State = State(currentPage: 0)
  var cancellable: Set<AnyCancellable> = []
}

extension CLNavigationIntent: CLNavigationIntentType, IntentType {
  typealias ViewAction = CLNavigationModel.ViewAction

  typealias State = CLNavigationModel.State

  func mutate(action: CLNavigationModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
    case .onTapNavTab(let index):
      state.currentPage = index
    case .onTapFinish:
      print("didTapFinish")
    case .onTapLogo:
      state.currentPage = 0
    case .onTapSwitchVehicleModel:
      print("didTapSwitchVehicleModel")
    }
  }
}

protocol CLNavigationIntentType {

  var state: CLNavigationModel.State { get }

  func send(action: CLNavigationModel.ViewAction)

  func send(action: CLNavigationModel.ViewAction, viewEffect: (() -> Void)?)

}
