//
//  HMGDetailButton.swift
//  Catalog
//
//  Created by Jung peter on 8/11/23.
//

import SwiftUI

protocol HMGStyle: ButtonStyle {

  var color: Color { get }

  @ViewBuilder func makeBody(configuration: Self.Configuration) -> Self.Body

}

extension HMGStyle {

  var color: Color {
    return .activeBlue2
  }

  func makeBody(configuration: Configuration) -> some View {
    HStack {
      configuration.label
    }
    .padding(EdgeInsets(top: 4.5, leading: 10, bottom: 4.5, trailing: 10))
    .background(color)
    .foregroundColor(.white)
  }

}

struct HMGButtonStyle: HMGStyle { }

struct HMGButtonArrowStyle: HMGStyle {

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
