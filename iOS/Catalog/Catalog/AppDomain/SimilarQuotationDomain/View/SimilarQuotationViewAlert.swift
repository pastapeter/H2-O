//
//  SimilarQuotationViewAlert.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/23.
//

import Foundation
import SwiftUI

extension SimilarQuotationView {
  enum AlertCase: Equatable {
    case help
    case noOption
    case optionButQuit
    case addOption(title: String, count: Int)
  }
}

extension SimilarQuotationView {
  func noOptionAlertView() -> some View {
    let buttonContent = ButtonContent(cancelAction: {
      intent.send(action: .showAlertChanged(showAlert: false))
    }, submitAction: {
      intent.send(action: .choiceQuit)
    }, submitText: "종료")
    return CLAlertView<CLSingleLineAlertContentView, ButtonContent, AlertDoubleButton>(info: "유사견적 페이지를 닫으시겠습니까?", items: buttonContent) { item in
      AlertDoubleButton(cancelAction: item.cancelAction, submitAction: item.submitAction, cancelText: item.cancelText, submitText: item.submitText)
    }
  }
  
  func optionButQuitAlertView() -> some View {
    let buttonContent = ButtonContent(cancelAction: {
      intent.send(action: .showAlertChanged(showAlert: false))
    }, submitAction: {
      intent.send(action: .choiceQuit)
    })
    return CLAlertView<CLOptionQuitAlertContentView, ButtonContent, AlertDoubleButton>(info: String(viewState.selectedOptions.count), items: buttonContent) { item in
      AlertDoubleButton(cancelAction: item.cancelAction, submitAction: item.submitAction, cancelText: item.cancelText, submitText: item.submitText)
    }
  }
  
  func addOptionAlertView(title: String, count: Int) -> some View {
    let buttonContent = ButtonContent(cancelAction: {
      intent.send(action: .showAlertChanged(showAlert: false))
    }, submitAction: {
      intent.send(action: .choiceAdd)
    })
    
    return CLAlertView<CLOptionSelectAlertContentView, ButtonContent, AlertSingleButton>(info: toAlertString(optionName: title, count: count), items: buttonContent) { item in
      AlertSingleButton(cancelAction: item.cancelAction, submitAction: item.submitAction, cancelText: item.cancelText, submitText: item.submitText)
    }
  }
}

private extension SimilarQuotationView {
  func toAlertString(optionName: String, count: Int) -> String {
    "[\(optionName)]외 \(count)개"
  }
}
