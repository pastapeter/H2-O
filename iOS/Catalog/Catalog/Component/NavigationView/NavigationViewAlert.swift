//
//  CLNavigationViewAlert.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/23.
//

import Foundation
import SwiftUI

extension AppMainRouteView {
  enum AlertCase: Equatable {
    case quit
    case guide
  }
}
extension AppMainRouteView {
  @ViewBuilder
  func makeAlertView(alertCase: AlertCase) -> some View {
    switch alertCase {
      case .quit:
        let buttonContent = ButtonContent(cancelAction: {
          intent.send(action: .showAlertChanged(showAlert: false))
        }, submitAction: {
          intent.send(action:.onTapFinish)
        }, submitText: "종료")
        
         CLAlertView<CLQuitAlertContentView, ButtonContent, AlertDoubleButton>(items: buttonContent) { item in
          AlertDoubleButton(cancelAction: item.cancelAction, submitAction: item.submitAction, cancelText: item.cancelText, submitText: item.submitText)}
      case .guide:
      EntryGuide(intent: intent)
        
    }
  }
}
