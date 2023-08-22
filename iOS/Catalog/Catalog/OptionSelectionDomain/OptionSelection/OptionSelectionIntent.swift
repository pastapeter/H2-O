//
//  OptionSelectionIntent.swift
//  Catalog
//
//  Created by Jung peter on 8/17/23.
//

import Foundation
import Combine

protocol OptionSelectionIntentType {

  var state: OptionSelectionModel.State { get }

  func send(action: OptionSelectionModel.ViewAction)

  func send(action: OptionSelectionModel.ViewAction, viewEffect: (() -> Void)?)
  
  var repository: OptionSelectionRepositoryProtocol { get }

}

protocol OptionSelectionCollectable: AnyObject {
  
  var selectedExtraOptions: Set<Int> { get }
  
  func selectedOption(with id: Int)
  
}

final class OptionSelectionIntent: ObservableObject {

  init(initialState: State, repository: OptionSelectionRepositoryProtocol) {
    state = initialState
    self.repository = repository
  }

  typealias State = OptionSelectionModel.State
  typealias ViewAction = OptionSelectionModel.ViewAction

  @Published var state: State

  var cancellable: Set<AnyCancellable> = []
  private(set) var selectedExtraOptions: Set<Int> = []
  private(set) var repository: OptionSelectionRepositoryProtocol

}

extension OptionSelectionIntent: OptionSelectionCollectable {
  
  func selectedOption(with id: Int) {
    if selectedExtraOptions.contains(id) {
      selectedExtraOptions.remove(id)
    } else {
      selectedExtraOptions.insert(id)
    }
  }

}

extension OptionSelectionIntent: OptionSelectionIntentType, IntentType {

  func mutate(action: OptionSelectionModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
    case .onTapTab(let index):
      state.currentPage = index
    case .onAppear:
      break
    }
  }

}
