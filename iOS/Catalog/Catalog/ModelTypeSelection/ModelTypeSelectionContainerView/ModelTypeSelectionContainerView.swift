//
//  ModelTypeSelectionContainerView.swift
//  Catalog
//
//  Created by Jung peter on 8/11/23.
//

import SwiftUI

struct ModelTypeSelectionContainerView: View {

  @State var isPresented = false
  @State var isModalPresented = false

    var body: some View {
      ScrollView {
        ZStack {
          LazyVStack(alignment: .leading) {
            Text("모델타입을 선택해주세요")
              .catalogFont(type: .HeadKRMedium18)
            ModelTypeView()
            ModelTypeView()
            ModelTypeView()
            ModelTypeView()
          }
          .padding(.horizontal, 16)
          if isPresented {
            DimmedZStack { }
              .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                  self.isModalPresented = true
                }
              }
          }
        }
        .blurredFullScreenCover(.init(.clear), show: $isModalPresented, onDismiss: { }) {
          ModelPopUp()
            .padding(EdgeInsets(top: 135, leading: 27, bottom: 135, trailing: 27))
        }
        .task {
          DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isPresented = true
          }
        }
      }
      .frame(maxWidth: .infinity)
    }
}

struct ModelTypeSelectionContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ModelTypeSelectionContainerView()
    }
}

extension View {

  func blurredSheet<Content: View>(_ style: AnyShapeStyle, show: Binding<Bool>, onDismiss: @escaping () -> Void, @ViewBuilder content: @escaping () -> Content) -> some View {
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

  func blurredFullScreenCover<Content: View>(_ style: AnyShapeStyle, show: Binding<Bool>, onDismiss: @escaping () -> Void, @ViewBuilder content: @escaping () -> Content) -> some View {
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
