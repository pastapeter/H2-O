//
//  OptionSelectionIntent.swift
//  Catalog
//
//  Created by Jung peter on 8/17/23.
//

import Foundation
import Combine

protocol OptionSelectionIntentType {

  var viewState: OptionSelectionModel.ViewState { get }
  
  var state: OptionSelectionModel.State { get }

  func send(action: OptionSelectionModel.ViewAction)

  func send(action: OptionSelectionModel.ViewAction, viewEffect: (() -> Void)?)
  
  var repository: OptionSelectionRepositoryProtocol { get }

}

protocol OptionSelectionCollectable: AnyObject {
  
  var selectedExtraOptions: Set<OptionCardModel.State> { get }
  
  func selectedOption(with option: OptionCardModel.State)
  
}

final class OptionSelectionIntent: ObservableObject {

  init(initialState: ViewState, repository: OptionSelectionRepositoryProtocol, quotation: OptionSelectionService) {
    viewState = initialState
    self.repository = repository
    self.quotation = quotation
  }

  typealias ViewState = OptionSelectionModel.ViewState
  typealias ViewAction = OptionSelectionModel.ViewAction
  typealias State = OptionSelectionModel.State

  @Published var viewState: ViewState
  var state: OptionSelectionModel.State = .init()

  var cancellable: Set<AnyCancellable> = []
  private(set) var selectedExtraOptions: Set<OptionCardModel.State> = []
  private(set) var repository: OptionSelectionRepositoryProtocol
  private var quotation: OptionSelectionService
}

extension OptionSelectionIntent: OptionSelectionCollectable {
  
  func selectedOption(with option: OptionCardModel.State) {
    
    if selectedExtraOptions.contains(option) {
      selectedExtraOptions.remove(option)
    } else {
      selectedExtraOptions.insert(option)
    }
    quotation.updateOption(to: Array(selectedExtraOptions))    
  }

}

extension OptionSelectionIntent: OptionSelectionIntentType, IntentType {

  func mutate(action: OptionSelectionModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
    case .onTapTab(let index):
      viewState.currentPage = index
    case .onAppear:
      break
    }
  }

}
