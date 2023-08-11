//
//  HMGDetailButton.swift
//  Catalog
//
//  Created by Jung peter on 8/11/23.
//

import SwiftUI

struct HMGButtonArrowStyle: ButtonStyle {

  private let color: Color = .activeBlue2

  func makeBody(configuration: Configuration) -> some View {

    HStack {
      Spacer()
      configuration.label
      Spacer().frame(width: 8)
      Image("chevron").renderingMode(.template)
    }
    .padding(.trailing, 5)
    .frame(width: 97, height: 32)
    .background(color)
    .foregroundColor(.white)

  }

}
