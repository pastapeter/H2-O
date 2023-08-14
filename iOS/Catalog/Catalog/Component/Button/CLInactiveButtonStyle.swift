//
//  CLInactiveButtonStyle.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/14.
//

import SwiftUI

struct CLInActiveButtonStyle: ButtonStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    CLInActiveStyleButton(configuration: configuration)
  }
}

private extension CLInActiveButtonStyle {
  struct CLInActiveStyleButton: View {
    @Environment(\.isEnabled) var isEnabled

    let configuration: CLInActiveButtonStyle.Configuration

    var body: some View {
      return configuration.label
        .background(isEnabled ? Color.primary700 : Color.gray300)
        .foregroundColor(isEnabled ? Color.gray50 : Color.white)
        .ignoresSafeArea()
    }
  }
}
