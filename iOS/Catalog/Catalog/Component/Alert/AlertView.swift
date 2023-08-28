//
//  Alertable.swift
//  Catalog
//
//  Created by Jung peter on 8/7/23.
//

import SwiftUI

protocol AlertContentable: View {

  var info: String? { get }

  init(info: String?)

}

protocol AlertView: View {

  associatedtype AlertContent: AlertContentable
  associatedtype ButtonContent: ButtonContentable
  associatedtype ButtonContentView: View
  var body: AlertViewComponent<AlertContent, ButtonContent, ButtonContentView> { get }

}
