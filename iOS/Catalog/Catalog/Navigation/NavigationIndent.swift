//
//  NavigationIndent.swift
//  Catalog
//
//  Created by Jung peter on 8/3/23.
//

import Foundation
import Combine

protocol NavigationIndentType {
  var state: NavigationModel.State { get }
  func send(action: NavigationModel.ViewAction)
  func send(action: NavigationModel.ViewAction, viewEffect: (() -> Void)?)
}

final class NavigationIndent: ObservableObject {

  // MARK: - LifeCycle

  init(initialState: State) {
    state = initialState
  }

  // MARK: - Internal
  typealias State = NavigationModel.State
  typealias ViewAction = NavigationModel.ViewAction

  @Published var state: State = State(currentPage: 0)
  var cancellable: Set<AnyCancellable> = []
}

extension NavigationIndent: NavigationIndentType, IntentType {
  
  func mutate(action: NavigationModel.ViewAction, viewEffect: (() -> Void)?) {
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
