import SwiftUI

struct TransparentZStack<Content>: View where Content: View {

  let content: () -> Content

  init(@ViewBuilder content: @escaping() -> Content) {
    self.content = content
  }

  var body: some View {
    ZStack {
      content()
    }
  }
}
