//
//  CLAlert.swift
//  Catalog
//
//  Created by Jung peter on 8/5/23.
//

import SwiftUI

struct CLAlertView<AlertContent: AlertContentable, ButtonContent: ButtonContentable, ButtonContentView: View>: AlertView {

  var info: String?
  var items: ButtonContent
  @ViewBuilder var contents: (ButtonContent) -> ButtonContentView
  var body: AlertViewComponent<AlertContent, ButtonContent, ButtonContentView> {
    AlertViewComponent(cancelAction: items.cancelAction, submitAction: items.submitAction, cancelText: items.cancelText, submitText: items.submitText) {
      AlertContent(info: info)
    } buttonContentView: { (buttonContent: ButtonContent) in
      contents(buttonContent)
    }
  }
}
