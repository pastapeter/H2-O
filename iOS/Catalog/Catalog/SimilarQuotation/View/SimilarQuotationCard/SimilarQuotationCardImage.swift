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
  var quotation: Quotation
}

extension SimilarQuotationCardImage: View {
    var body: some View {
      HStack {
        VStack(alignment: .leading, spacing: 0) {
          Text(quotation.state.totalPrice.wonWithSpacing)
            .catalogFont(type: .HeadKRMedium18)
            .foregroundColor(.primary700)
          Text(similarQuotation.price.signedWon)
            .catalogFont(type: .TextKRRegular12)
            .foregroundColor(.sand)
        }
        Spacer()
        AsyncImage(url: similarQuotation.image, content: { image in
          image
            .resizable()
            .scaledToFill()
            .frame(width: CGFloat(343).scaledWidth)
        }, placeholder: {
          ProgressView()
        })
        .frame(maxHeight: .infinity, alignment: .trailing)
      }
    }
}
