//
//  AlertViewComponent.swift
//  Catalog
//
//  Created by Jung peter on 8/7/23.
//

import SwiftUI

protocol ButtonContentable {
  var cancelAction: (() -> Void)? { get set }
  var submitAction: () -> Void { get set }
  var cancelText: String? { get set }
  var submitText: String? { get set }
  
  init(cancelAction: (() -> Void)?, submitAction: @escaping () -> Void, cancelText: String?, submitText: String?)
}

struct AlertViewComponent<AlertContent: View, ButtonContent: ButtonContentable, ButtonContentView: View>: View {

  var cancelAction: (() -> Void)?
  var submitAction: () -> Void
  var cancelText: String?
  var submitText: String?
  @ViewBuilder var content: () -> AlertContent
  @ViewBuilder var buttonContentView: (ButtonContent) -> ButtonContentView
  var body: some View {
    DimmedZStack {
      VStack {
        content()
        buttonContentView(ButtonContent(cancelAction: cancelAction, submitAction: submitAction, cancelText: cancelText, submitText: submitText))
      }
      .background(.white)
      .cornerRadius(5)
      .padding(.horizontal, 20)
    }
  }
}

struct ButtonContent: ButtonContentable {
  var cancelAction: (() -> Void)?
  
  var submitAction: () -> Void
  
  var cancelText: String?
  
  var submitText: String?
  
  init(cancelAction: (() -> Void)? = nil, submitAction: @escaping () -> Void, cancelText: String? = nil, submitText: String? = nil) {
    
    self.cancelText = cancelText
    self.cancelAction = cancelAction
    self.submitText = submitText
    self.submitAction = submitAction
  }
  
  
}
