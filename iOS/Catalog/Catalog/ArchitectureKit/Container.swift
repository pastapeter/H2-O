//
//  Container.swift
//  Catalog
//
//  Created by Jung peter on 8/1/23.
//

import Combine
import Foundation

final class Container<Intent, ViewState>: ObservableObject {

  // MARK: Lifecycle

  init(
    intent: Intent,
    state: ViewState,
    modelChangePublisher: ObjectWillChangePublisher) {
    self.intent = intent
    self.state = state

    modelChangePublisher
      .receive(on: RunLoop.main)
      .sink(receiveValue: objectWillChange.send)
      .store(in: &cancellable)
  }

  // MARK: Internal

  let intent: Intent
  let state: ViewState

  // MARK: Private

  private var cancellable: Set<AnyCancellable> = []

}
