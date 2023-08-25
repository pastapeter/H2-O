//
//  QuotationExternalView.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/17.
//

import SwiftUI

struct QuotationExteriorView: View {
  let quotation: QuotationCompleteService
  let modalTopHeight: CGFloat = 30
  let titleTopPadding: CGFloat = 177
  let externalImageHeight: CGFloat = 222

    var body: some View {
      VStack {
        Spacer().frame(height: titleTopPadding)
        Text(quotation.trimName())
          .catalogFont(type: .HeadKRBold65)
          .foregroundColor(.white)
        AsyncCachedImage(url: quotation.exteriorImage()) { image in
          image
            .resizable()
            .frame(maxWidth: .infinity, maxHeight: externalImageHeight)
        }
      }
      .background(
        Image("QuotationCompleteBackground")
          .resizable()
          .scaledToFill()
      )
    }
}

