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
      print("didTapLogo")
    case .onTapSwitchVehicleModel:
      print("didTapSwitchVehicleModel")
    }
  }
}
