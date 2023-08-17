//
//  QuotationInteriorView.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/17.
//

import SwiftUI

struct QuotationInteriorView: View {
  var quotation = Quotation.shared
  var body: some View {
    ZStack {
      GeometryReader { proxy in
        ScrollView(.horizontal, showsIndicators: false) {
          AsyncImage(url: quotation.state.quotation?.trim.internalImage) { img in
            img
              .resizable()
              .aspectRatio(contentMode: .fit)
          } placeholder: {
            EmptyView()
          }
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
