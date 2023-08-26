//
//  QuotationInteriorView.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/17.
//

import SwiftUI

struct QuotationInteriorView: View {
  let quotation: QuotationCompleteService
  let imageHalfWidth: CGFloat = 360
  @State var offset: CGFloat = 0
  var body: some View {
    HStack {
      GeometryReader { proxy in
        AsyncCachedImage(url: quotation.interiorImage()) { img in
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
        }
        .frame(minWidth: proxy.size.width, maxHeight: proxy.size.height)
      }
    }
  }
}

