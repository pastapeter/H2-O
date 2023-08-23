//
//  HelpIcon.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/23.
//

import SwiftUI

struct HelpIcon: View {
  var intent: SimilarQuotationIntentType
  @Binding var showAlert: Bool
  
  var body: some View {
      VStack(alignment: .trailing) {
        HStack(alignment: .top, spacing: 0) {
          Spacer()
          Button {
            showAlert.toggle()
            intent.send(action: .onTapHelpButton)
          } label: {
            Image("help").frame(width: 24, height: 24)
          }
        }
        Spacer()
      }
      .padding(.top, 32)
      .padding(.horizontal, 16)
    }
}

