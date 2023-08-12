//
//  CLDialog.swift
//  Catalog
//
//  Created by Jung peter on 8/13/23.
//

import SwiftUI

extension View {

  @ViewBuilder
  func CLDialogFullScreenCover<Content: View>(show: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
    self
      .modifier(CLDialogView(show: show, overlay: content()))
  }
}

private struct CLDialogView<Overlay: View>: ViewModifier {

  @Binding var show: Bool
  var overlay: Overlay

  @State private var hostView: CustomHostingView<Overlay>?
  @State private var parentController: UIViewController?

  func body(content: Content) -> some View {
    content
    // parentController 붙이기
      .background(content: {
        ExtractSwiftUIParentController(content: overlay, hostView: $hostView) { viewController in
          parentController = viewController
        }
      })
    // Host View 초기화
      .onAppear {
          hostView = CustomHostingView(show: $show, rootView: overlay)
      }
      .onChange(of: show) { newValue in
        if newValue {
          if let hostView {
            hostView.modalPresentationStyle = .overCurrentContext
            hostView.modalTransitionStyle = .crossDissolve
            hostView.view.backgroundColor = .clear
            parentController?.present(hostView, animated: false)
          }
        } else {
          hostView?.dismiss(animated: false)
        }
      }
  }

}

private struct ExtractSwiftUIParentController<Content: View>: UIViewRepresentable {

  var content: Content
  @Binding var hostView: CustomHostingView<Content>?
  var parentController: (UIViewController?) -> Void

  func makeUIView(context: Context) -> some UIView {
    return UIView()
  }

  func updateUIView(_ uiView: UIViewType, context: Context) {
    hostView?.rootView = content
    DispatchQueue.main.async {
      parentController(uiView.superview?.superview?.parentController)
    }
  }

}

class CustomHostingView<Content: View>: UIHostingController<Content> {

  @Binding var show: Bool

  init(show: Binding<Bool>, rootView: Content) {
    self._show = show
    super.init(rootView: rootView)
  }

  required dynamic init?(coder aDecoder: NSCoder) {
    fatalError("Not Using Storyboard")
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(false)
    show = false
  }

}

public extension UIView {

  var parentController: UIViewController? {
    var responder = self.next
    while responder != nil {
      if let viewController = responder as? UIViewController {
        return viewController
      }
      responder = responder?.next
    }
    return nil
  }

}
