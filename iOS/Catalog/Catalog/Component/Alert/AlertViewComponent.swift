//
//  AlertViewComponent.swift
//  Catalog
//
//  Created by Jung peter on 8/7/23.
//

import SwiftUI

struct AlertViewComponent<AlertContent: View>: View {

  var cancelAction: () -> Void
  var submitAction: () -> Void

  @ViewBuilder var content: () -> AlertContent
  var body: some View {
    VStack {
      content()
      CLDualChoiceButton(leftText: "취소",
                         rightText: "종료",
                         height: 52,
                         leftAction: { cancelAction() },
                         rightAction: { submitAction() })
    }
    .background(.white)
    .cornerRadius(5)
  }
}
