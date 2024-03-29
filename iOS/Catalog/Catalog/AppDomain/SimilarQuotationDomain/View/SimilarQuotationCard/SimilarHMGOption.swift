//
//  SimilarHMGOption.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/20.
//

import SwiftUI

struct SimilarHMGOption: View {
  var option: SimilarQuotationOption
  var intent: SimilarQuotationIntentType
  var state: SimilarQuotationModel.State
  
  var body: some View {
    Button {
      intent.send(action: .optionSelected(selectedOption: option))
    } label: {
      VStack(spacing: 0) {
        AsyncCachedImage(url: option.imageURL) { image in
          image
            .resizable()
        } 
        .frame(height: CGFloat(89).scaledHeight)

        VStack(alignment: .leading, spacing: 0) {
          Text(option.name)
            .catalogFont(type: .HeadKRMedium14)
            .foregroundColor(intent.viewState.selectedOptions.contains(option) ? Color.gray900 : Color.gray600)
            .frame(height: CGFloat(35).scaledHeight)
          
          HStack(spacing: 0) {
            Text(option.price?.signedWon ?? "")
              .catalogFont(type: .HeadKRMedium14)
              .foregroundColor(intent.viewState.selectedOptions.contains(option) ? Color.gray900 : Color.gray600)
              .frame(height: CGFloat(10).scaledHeight)

            Spacer()
            (intent.viewState.selectedOptions.contains(option) ? Image("blue_check") : Image("gray_check"))
              .padding(10)
          }
        }
        .padding(.horizontal, 8)
      }
      .selectedCardStyle(isSelected: intent.viewState.selectedOptions.contains(option))
      .buttonSelected(isselected: intent.viewState.selectedOptions.contains(option))
    }
    .buttonStyle(EmptyButtonStyle())
    .padding(.bottom, 12)
  }

}
