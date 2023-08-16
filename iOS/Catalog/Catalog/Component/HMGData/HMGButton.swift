//
//  HMGBUtton.swift
//  Catalog
//
//  Created by Jung peter on 8/16/23.
//

import SwiftUI

struct HMGButton: View {

  var action: () -> Void

  var body: some View {
    makeDetailButton()
  }

  @ViewBuilder
  func makeDetailButton() -> some View {
    ZStack {
      Button {
        action()
      } label: {
        Text("HMG Data")
          .catalogFont(type: .HeadENBold10)
      }
      .buttonStyle(HMGButtonArrowStyle())
    }
  }
}

struct HMGBUtton_Previews: PreviewProvider {
  static var previews: some View {
    HMGButton(action: { })
  }
}
