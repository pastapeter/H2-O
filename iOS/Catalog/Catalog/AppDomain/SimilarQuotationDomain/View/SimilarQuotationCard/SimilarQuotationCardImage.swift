//
//  SimilarQuotationCardImage.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/21.
//

import SwiftUI

struct SimilarQuotationCardImage {
  var similarQuotation: SimilarQuotation
  var intent: SimilarQuotationIntentType
}

extension SimilarQuotationCardImage: View {
    var body: some View {
      HStack {
        GeometryReader { proxy in
          VStack(alignment: .leading, spacing: 0) {
            Text(similarQuotation.price.wonWithSpacing)
              .catalogFont(type: .HeadKRMedium18)
              .foregroundColor(.primary700)
            Text((similarQuotation.price - intent.quotation.totalPrice).signedWon)
            
              .catalogFont(type: .TextKRRegular12)
              .foregroundColor(.sand)
          }
          .padding(.top, CGFloat(48).scaledHeight)
          Spacer().frame(maxWidth: .infinity)
          AsyncCachedImage(url: similarQuotation.image, content: { image in
            image
              .resizable()
              .scaledToFit()
              .frame(height: CGFloat(139).scaledHeight)
          })
          .offset(x: proxy.size.width / 2)
        }
      }
      .clipped()
    }
}
