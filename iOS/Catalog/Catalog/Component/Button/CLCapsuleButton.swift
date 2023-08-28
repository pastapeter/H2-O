//
//  CLCapsuleButton.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/21.
//

import SwiftUI

struct CLCapsuleButton {
  let (width, height): (CGFloat, CGFloat)
  let text: String
  let action: () -> Void
}
extension CLCapsuleButton: View {
    var body: some View {
      Button {
          action()
      } label: {
        Text(text)
          .catalogFont(type: .TextKRMedium14)
          .frame(width: width, height: height)
          .foregroundColor(Color.primary0)
          .overlay(
            Capsule(style: .continuous)
              .stroke(Color.primary0)
          )
      }
      .buttonStyle(.plain)
    }
}


