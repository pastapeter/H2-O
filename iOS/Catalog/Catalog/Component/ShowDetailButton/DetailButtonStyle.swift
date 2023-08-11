//
//  DetailButtonStyle.swift
//  Catalog
//
//  Created by Jung peter on 8/11/23.
//

import SwiftUI

struct DetailButtonStyle: ButtonStyle {

  private let color: Color = .gray800

  func makeBody(configuration: Configuration) -> some View {

    HStack {
      Spacer()
      configuration.label
      Spacer().frame(width: 10)
      Image("chevron").renderingMode(.template)
    }
    .padding(.trailing, 5)
    .frame(width: 97, height: 32)
    .background(.white)
    .foregroundColor(color)

  }

}
