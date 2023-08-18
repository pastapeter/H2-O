//
//  QuotationInteriorView.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/17.
//

import SwiftUI

struct QuotationInteriorView: View {
  var quotation = Quotation.shared
  let imageHalfWidth: CGFloat = 360
  @State var offset: CGFloat = 0
  var body: some View {
    HStack {
      GeometryReader { proxy in
        AsyncImage(url: quotation.state.quotation?.trim.internalImage) { img in
          img
            .offset(x: offset)
            .gesture(
              DragGesture()
                .onChanged { drag in
                  let nextOffset = offset + (drag.translation.width * 0.1)
                  if abs(nextOffset) < imageHalfWidth {
                    offset = nextOffset
                  }
                }
            )
        } placeholder: {
          EmptyView()
        }
        .frame(minWidth: proxy.size.width, maxHeight: proxy.size.height)
      }
    }
  }
}

struct QuotationInteriorView_Previews: PreviewProvider {
  static var previews: some View {
    QuotationInteriorView()
  }
}
