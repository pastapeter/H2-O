//
//  IntentBindingType.swift
//  Catalog
//
//  Created by Jung peter on 8/1/23.
//

import Foundation

protocol IntentBindingType {

  associatedtype IntentType
  associatedtype ViewState
  associatedtype State

  var container: Container<IntentType, ViewState, State> { get }
  var intent: IntentType { get }
  var viewState: ViewState { get }
  var state: State { get }

}
