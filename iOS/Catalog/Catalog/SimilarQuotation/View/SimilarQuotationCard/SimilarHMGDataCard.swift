//
//  SimilarHMGDataCard.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/19.
//

import SwiftUI


struct SimilarHMGDataCard {
  var state: SimilarQuotationModel.State
  var options: [SimilarQuotationOption]
  var intent: SimilarQuotationIntentType
}

extension SimilarHMGDataCard: View {
  
  var body: some View {
    ZStack(alignment: .leading) {
      
      VStack(alignment: .leading) {
        HMGTag()
        Spacer()
      }
      .padding(.horizontal, 18)
      
      VStack(alignment: .leading , spacing: 0) {
        Text("내 견적에 없는 옵션이에요.")
          .catalogFont(type: .TextKRMedium12)
          .frame(width: CGFloat(125).scaledWidth, height: CGFloat(16).scaledHeight)
          .padding(.top, CGFloat(33).scaledHeight)
          .padding(.bottom, CGFloat(9).scaledHeight)
        
        HStack(spacing: 8) {
          ForEach(options.indices, id: \.self) { optionIndex in
            SimilarHMGOption(option: options[optionIndex], intent: intent, state: state)
          }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
      }
      .padding(.horizontal, 18)
    }
    .background(Color.gray50)
  }
}
