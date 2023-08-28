//
//  CLDialog.swift
//  Catalog
//
//  Created by Jung peter on 8/13/23.
//

import SwiftUI

extension View {

  func blurredSheet<Content: View>(_ style: AnyShapeStyle,
                                   show: Binding<Bool>,
                                   onDismiss: @escaping () -> Void,
                                   @ViewBuilder content: @escaping () -> Content) -> some View {
    self
      .sheet(isPresented: show, onDismiss: onDismiss) {
        content()
          .background(RemovebackgroundColor())
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .background {
            Rectangle()
              .fill(style)
              .ignoresSafeArea(.container, edges: .all)
          }
      }
  }

  func blurredFullScreenCover<Content: View>(_ style: AnyShapeStyle,
                                             show: Binding<Bool>,
                                             onDismiss: @escaping () -> Void,
                                             @ViewBuilder content: @escaping () -> Content) -> some View {
    self
      .fullScreenCover(isPresented: show, onDismiss: onDismiss) {
        content()
          .background(RemovebackgroundColor())
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .background {
            Rectangle()
              .fill(style)
              .ignoresSafeArea(.container, edges: .all)
          }
      }
  }

}

private struct RemovebackgroundColor: UIViewRepresentable {

  func makeUIView(context: Context) -> some UIView {
    return UIView()
  }

  func updateUIView(_ uiView: UIViewType, context: Context) {
    DispatchQueue.main.async {
      uiView.superview?.superview?.backgroundColor = .clear
    }
  }

}
