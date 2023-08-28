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
  let externalImageHeight: CGFloat = 190

    var body: some View {
      VStack(spacing: 0) {
        Spacer().frame(height: titleTopPadding)
        Text(quotation.trimName())
          .catalogFont(type: .HeadKRBold65)
          .foregroundColor(.white)
        AsyncCachedImage(url: quotation.exteriorImage()) { image in
          image
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity, maxHeight: externalImageHeight)
        }
        Spacer()
      }
      .background(
        LinearGradient(colors: [Color("QuotationCompleteTop"), Color("QuotationCompleteMiddle"), Color.white], startPoint: .top, endPoint: .bottom)
      )
    }
}

