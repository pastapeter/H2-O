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

  var cancelAction: () -> Void { get }

  var submitAction: () -> Void { get }

  var body: AlertViewComponent<AlertContent> { get }

}
