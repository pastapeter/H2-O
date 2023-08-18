//
//  OptionCardViewIntent.swift
//  Catalog
//
//  Created by Jung peter on 8/18/23.
//

import Foundation
import Combine

protocol OptionCardViewIntentType {
  
  var state: OptionCardModel.State { get }

  func send(action: OptionCardModel.ViewAction)

  func send(action: OptionCardModel.ViewAction, viewEffect: (() -> Void)?)
  
}

final class OptionCardViewIntent: ObservableObject {
  
  init(initialState: State, parent: OptionCardScrollIntentType) {
    state = initialState
    self.parent = parent
  }
  
  typealias State = OptionCardModel.State
  typealias ViewAction = OptionCardModel.ViewAction
  
  @Published var state: State
  
  var cancellable: Set<AnyCancellable> = []
  weak var parent: OptionCardScrollIntentType?
  
}

extension OptionCardViewIntent: OptionCardViewIntentType, IntentType {
  
  func mutate(action: OptionCardModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
    case .onTapDetail:
      viewEffect?()
    case .onTap(let id):
      parent?.send(action: .onTapOption(id: id))
      viewEffect?()
    }
  }
  
}
