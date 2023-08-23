//
//  AlertSingleButton.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/22.
//

import SwiftUI

struct AlertSingleButton: View {

  var cancelAction: (() -> Void)?
  var submitAction: () -> Void
  var cancelText: String?
  var submitText: String?

  init(cancelAction: (() -> Void)?, submitAction: @escaping () -> Void, cancelText: String?, submitText: String?) {
    self.submitAction = submitAction
    if let text = submitText {
      self.submitText = text
    }
  }

  var body: some View {
    CLButton(mainText: submitText ?? "확인", height: 52, backgroundColor: Color.primary700, buttonAction: {submitAction()} )
  }
}
