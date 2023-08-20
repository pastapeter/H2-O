//
//  SimilarQuotationCard.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/19.
//

import SwiftUI

struct SimilarQuotationCard: View {
  let quotation = Quotation.shared
  var intent: SimilarQuotationIntentType
  var index: Int
  var trimName: String
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
        VStack(spacing: 0) {
          HStack {
            VStack(alignment: .leading, spacing: 0) {
              Text("\((index+1).toString())번째 유사견적서")
                .catalogFont(type: .TextKRRegular12)
                .foregroundColor(Color.gray900)
              Text(trimName)
                .catalogFont(type: .HeadKRBold26)
                .foregroundColor(Color.primary700)
              HStack(spacing: 8) {
                Text(intent.state.similarQuotations[index].powertrainName).modelTypeCard()
                Text(intent.state.similarQuotations[index].bodytypeName).modelTypeCard()
                Text(intent.state.similarQuotations[index].drivetrainName).modelTypeCard()
              }
            }
            Spacer()
          }
          .padding(.top, 24)
          
          HStack {
            VStack(alignment: .leading, spacing: 0) {
              Text(quotation.state.totalPrice.wonWithSpacing)
                .catalogFont(type: .HeadKRMedium18)
                .foregroundColor(.primary700)
              Text(intent.state.similarQuotations[index].price.signedWon)
                .catalogFont(type: .TextKRRegular12)
                .foregroundColor(.sand)
            }
            Spacer()
            AsyncImage(url: intent.state.similarQuotations[index].image, content: { image in
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
        .padding(.leading, 21)
        
        SimilarHMGDataCard(options: intent.state.similarQuotations[index].options, intent: intent)
        .frame(maxHeight: CGFloat(220).scaledHeight)
      }
  }
  
}


extension Int {
  func toString() -> String {
    switch self {
      case 1 :  return "첫"
      case 2: return "두"
      case 3: return "세"
      case 4: return "네"
      default: return ""
    }
  }
  
}

extension Text {
  @ViewBuilder
  func modelTypeCard() -> some View {
    self
      .catalogFont(type: .TextKRRegular12)
      .foregroundColor(.gray500)
      .padding(.horizontal, 4)
      .background(Color.gray100)
  }
}
