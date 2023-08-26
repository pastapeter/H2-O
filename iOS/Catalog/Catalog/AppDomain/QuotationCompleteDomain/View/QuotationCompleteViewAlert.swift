//
//  QuotationCompleteViewAlert.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/23.
//

import Foundation
import SwiftUI


extension QuotationCompleteView {
  enum AlertCase: Equatable {
    case modify(index: Int, title: String)
    case delete(id: Int)
  }
}

extension QuotationCompleteSheet {
  func modifyAlertView(index: Int, title: String) -> some View {
    let buttonContent = ButtonContent(cancelAction: {
      intent.send(action: .showSheetChanged(showSheet: false))
    }, submitAction: {
      intent.send(action: .movePage(navigationIndex: index))
    }, submitText: "이동")
    return CLAlertView<CLSingleLineAlertContentView, ButtonContent, AlertDoubleButton>(info : "\(title) 선택 페이지로 이동합니다.", items: buttonContent) { item in
      AlertDoubleButton(cancelAction: item.cancelAction, submitAction: item.submitAction, cancelText: item.cancelText, submitText: item.submitText)
    }
  }
  
  func deleteAlertView(id: Int) -> some View {
    let buttonContent = ButtonContent(cancelAction: {
      intent.send(action: .showSheetChanged(showSheet: false))
    }, submitAction: {
      intent.send(action: .deleteOption(optionId: id))
    }, submitText: "삭제")
    return CLAlertView<CLSingleLineAlertContentView, ButtonContent, AlertDoubleButton>(info : "옵션을 삭제하시겠습니까?", items: buttonContent) { item in
      AlertDoubleButton(cancelAction: item.cancelAction, submitAction: item.submitAction, cancelText: item.cancelText, submitText: item.submitText)
    }
  }
}
