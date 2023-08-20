//
//  SimilarHMGOption.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/20.
//

import SwiftUI

struct SimilarHMGOption: View {
  let option: SimilarQuotationOption
  var action: () -> Void
  var body: some View {
    Button {
      action()
    } label: {
      VStack(spacing: 0) {
        AsyncImage(url: option.image) { image in
          image
            .resizable()
        } placeholder: {
          ProgressView()
        }
        .frame(height: CGFloat(89).scaledHeight)

        VStack(alignment: .leading, spacing: 0) {
          Text(option.name)
            .catalogFont(type: .HeadKRMedium14)
            .frame(height: CGFloat(35).scaledHeight)
          
          HStack(spacing: 0) {
            Text(option.price.signedWon)
              .catalogFont(type: .HeadKRMedium14)
              .frame(height: CGFloat(10).scaledHeight)

            Spacer()
            Image("check")
          }
        }
        .padding(.horizontal, 8)
      }
      .selectedCardStyle(isSelected: option.isSelected)
      .buttonSelected(isselected: option.isSelected)
    }
    .buttonStyle(EmptyButtonStyle())
    .padding(.bottom, 12)
  }

}
