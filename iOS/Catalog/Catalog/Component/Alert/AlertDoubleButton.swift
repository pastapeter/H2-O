//
//  AlertDoubleButton.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/22.
//

import SwiftUI

struct AlertDoubleButton: View {

  var cancelAction: (() -> Void)?
  var submitAction: () -> Void
  var cancelText: String?
  var submitText: String?

  init(cancelAction: (() -> Void)?, submitAction: @escaping () -> Void, cancelText: String?, submitText: String?) {
    if let action = cancelAction {
      self.cancelAction = action
    }
    self.submitAction = submitAction
    if let text = cancelText {
      self.cancelText = text
    }
    if let text = submitText {
      self.submitText = text
    }
  }
  
  var body: some View {
    CLDualChoiceButton(leftText: cancelText ?? "취소",
                       rightText: submitText ?? "확인",
                       height: 52,
                       leftAction: { (cancelAction ?? submitAction)() },
                       rightAction: { submitAction() })
  }
}
