//
//  IntentType.swift
//  Catalog
//
//  Created by Jung peter on 8/1/23.
//

import Foundation
import Combine

protocol IntentType: AnyObject {
  associatedtype ViewAction
  associatedtype State

  var state: State { get set }
  var cancellable: Set<AnyCancellable> { get set }

  func send(action: ViewAction)
  func send(action: ViewAction, viewEffect: (() -> Void)?)
  func mutate(action: ViewAction, viewEffect: (() -> Void)?)
}

extension IntentType {

  func send(action: ViewAction) {
    mutate(action: action, viewEffect: .none)
  }

  func send(action: ViewAction, viewEffect: (() -> Void)?) {
    mutate(action: action, viewEffect: viewEffect)
  }
}
