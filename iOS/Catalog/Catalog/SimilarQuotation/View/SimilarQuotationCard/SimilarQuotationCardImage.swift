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
        VStack(alignment: .leading, spacing: 0) {
          Text(intent.quotation.totalPriceInSimilarQuotation().wonWithSpacing)
            .catalogFont(type: .HeadKRMedium18)
            .foregroundColor(.primary700)
          Text(similarQuotation.price.signedWon)
            .catalogFont(type: .TextKRRegular12)
            .foregroundColor(.sand)
        }
        Spacer()
        AsyncCachedImage(url: similarQuotation.image, content: { image in
          image
            .resizable()
            .scaledToFill()
            .frame(width: CGFloat(343).scaledWidth)
        })
        .frame(maxHeight: .infinity, alignment: .trailing)
      }
    }
}
