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
  
  var selectedExtraOptions: Set<OptionCardModel.State> { get }
  
  func selectedOption(with option: OptionCardModel.State)
  
}

final class OptionSelectionIntent: ObservableObject {

  init(initialState: State, repository: OptionSelectionRepositoryProtocol, quotation: OptionSelectionService) {
    state = initialState
    self.repository = repository
    self.quotation = quotation
  }

  typealias State = OptionSelectionModel.State
  typealias ViewAction = OptionSelectionModel.ViewAction

  @Published var state: State

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
      
      quotation.updateOption(to: Array(selectedExtraOptions))
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
