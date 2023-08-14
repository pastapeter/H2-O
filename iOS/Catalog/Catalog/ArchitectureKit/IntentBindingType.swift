//
//  IntentBindingType.swift
//  Catalog
//
//  Created by Jung peter on 8/1/23.
//

import Foundation

protocol IntentBindingType {

  associatedtype IntentType
  associatedtype State

  var container: Container<IntentType, State> { get }
  var intent: IntentType { get }
  var state: State { get }

}
