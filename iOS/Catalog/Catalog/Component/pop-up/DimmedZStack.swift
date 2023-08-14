//
//  DimmedZStack.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/06.
//

import SwiftUI

struct DimmedZStack<Content>: View where Content: View {

  let content: () -> Content

  init(@ViewBuilder content: @escaping() -> Content) {
    self.content = content
  }

  var body: some View {
    ZStack {
      Color.gray900.ignoresSafeArea().background(.thickMaterial).opacity(0.7)
      content()
    }
  }
}
