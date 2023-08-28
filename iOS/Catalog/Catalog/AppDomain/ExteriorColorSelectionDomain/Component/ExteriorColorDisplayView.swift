//
//  ExteriorColorDisplayView.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import SwiftUI

struct ExteriorColorDisplayView: ColorContentable {

  var isSelected: Bool
  var color: CarColorType

    var body: some View {
      colorDisplayView()
    }

  @ViewBuilder
  func colorDisplayView() -> some View {
    switch color {
    case .exterior(let hexColor):
      VStack {
        Spacer().frame(height: CGFloat(12).scaledHeight)
        ZStack {
          Circle()
            .strokeBorder(isSelected ? Color.activeBlue : .gray100, lineWidth: 4)
          Circle()
            .fill(Color(hex: hexColor))
            .padding(.all, 6)
        }
        .frame(width: CGFloat(50).scaledWidth, height: CGFloat(50).scaledHeight)
      }
    default:
      EmptyView()
    }
  }
}
