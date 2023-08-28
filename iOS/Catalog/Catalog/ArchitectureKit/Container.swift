//
//  Container.swift
//  Catalog
//
//  Created by Jung peter on 8/1/23.
//

import Combine
import Foundation

final class Container<Intent, ViewState, State>: ObservableObject {
  
  // MARK: Lifecycle
  
  init(
    intent: Intent,
    viewState: ViewState,
    state: State,
    modelChangePublisher: ObjectWillChangePublisher) {
      self.intent = intent
      self.viewState = viewState
      self.state = state
      
      modelChangePublisher
        .receive(on: RunLoop.main)
        .sink(receiveValue: objectWillChange.send)
        .store(in: &cancellable)
    }
  
  // MARK: Internal
  
  let intent: Intent
  let viewState: ViewState
  let state: State
  
  // MARK: Private
  
  private var cancellable: Set<AnyCancellable> = []
  
}
