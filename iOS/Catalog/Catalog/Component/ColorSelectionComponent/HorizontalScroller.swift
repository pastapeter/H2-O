//
//  HorizontalScroller.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import SwiftUI

struct HorizontalScroller<Content: View>: View {

  var height: CGFloat = 400
  @ViewBuilder var content: () -> Content

  var body: some View {
    VStack(alignment: .leading) {
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack {
          content()
        }
      }
      .frame(maxHeight: height)
    }
  }

}
