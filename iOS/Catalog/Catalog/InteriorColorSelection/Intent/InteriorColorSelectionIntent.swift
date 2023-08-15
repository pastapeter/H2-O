//
//  InteriorColorSelectionIntent.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import Foundation
import Combine

protocol InteriorColorSelectionIntentType {
  
  var state: InteriorColorSelectionModel.State { get }
  
  func send(action: InteriorColorSelectionModel.ViewAction)
  
  func send(action: InteriorColorSelectionModel.ViewAction, viewEffect: (() -> Void)?)
  
}

final class InteriorColorSelectionIntent: ObservableObject {
  
  init(initialState: State) {
    state = initialState
  }
  
  typealias State = InteriorColorSelectionModel.State
  
  typealias ViewAction = InteriorColorSelectionModel.ViewAction
  
  @Published var state: State
  
  var cancellable: Set<AnyCancellable> = []
  
}

extension InteriorColorSelectionIntent: InteriorColorSelectionIntentType, IntentType {
  
  func mutate(action: InteriorColorSelectionModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
    case .onAppear:
      return
    case .trimColors(let colors):
      return
    case .changeSelectedInteriorImageURL(let url):
      return
    case .onTapColor(let id):
      return
    }
  }
  
}
