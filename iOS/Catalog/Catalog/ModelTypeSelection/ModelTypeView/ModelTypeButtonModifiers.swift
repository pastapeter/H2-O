//
//  ModelTypeButtonModifier.swift
//  Catalog
//
//  Created by Jung peter on 8/12/23.
//

import SwiftUI

struct ModelButtonSelectedBackground: ViewModifier {

  func body(content: Content) -> some View {

    content
      .background(Color.cardBG)
      .overlay(RoundedRectangle(cornerRadius: 4)
        .inset(by: 0.5)
        .stroke(Color.activeBlue2)
      )
  }

}

struct ModelButtonUnSelectedBackground: ViewModifier {

  func body(content: Content) -> some View {

    content
      .background(Color.white)
      .cornerRadius(4)
    }

}
