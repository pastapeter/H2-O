//
//  CLAlert.swift
//  Catalog
//
//  Created by Jung peter on 8/5/23.
//

import SwiftUI

struct CLAlertView<AlertContent: AlertContentable>: AlertView {
  var info: String?
  private(set) var cancelAction: () -> Void
  private(set) var submitAction: () -> Void
  var body: AlertViewComponent<AlertContent> {
    AlertViewComponent(cancelAction: cancelAction, submitAction: submitAction, content: {
      AlertContent(info: info)
    })
  }
}

extension CLAlertView {
  @ViewBuilder
  static func build(cancelAction: @escaping ()->Void, submitAction: @escaping () -> Void) -> some View {
    CLAlertView(cancelAction: cancelAction, submitAction: submitAction)
  }
}

struct CLAlertView_Previews: PreviewProvider {
  static var previews: some View {
    CLAlertView<CLSingleLineAlertContentView>(cancelAction: { }, submitAction: { })
  }
}
