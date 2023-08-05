//
//  NavigationIndent.swift
//  Catalog
//
//  Created by Jung peter on 8/3/23.
//

import Foundation
import Combine

protocol CLNavigationIndentType {
  var state: CLNavigationModel.State { get }
  func send(action: CLNavigationModel.ViewAction)
  func send(action: CLNavigationModel.ViewAction, viewEffect: (() -> Void)?)
}

final class CLNavigationIndent: ObservableObject {

  // MARK: - LifeCycle

  init(initialState: State) {
    state = initialState
  }

  // MARK: - Internal
  typealias State = CLNavigationModel.State
  typealias ViewAction = CLNavigationModel.ViewAction

  @Published var state: State = State(currentPage: 0)
  var cancellable: Set<AnyCancellable> = []
}

extension CLNavigationIndent: CLNavigationIndentType, IntentType {
  
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
