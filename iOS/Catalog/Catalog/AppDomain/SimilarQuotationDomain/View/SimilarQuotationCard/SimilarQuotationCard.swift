//
//  SimilarQuotationCard.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/19.
//

import SwiftUI

struct SimilarQuotationCard {
  var index: Int
  var similarQuotation: SimilarQuotation
  var intent: SimilarQuotationIntentType
  var state: SimilarQuotationModel.State
  var trimName: String
  let leadingPadding = CGFloat(21).scaledHeight
  let cardHeight = CGFloat(220).scaledHeight
}
extension SimilarQuotationCard: View {
 
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
        VStack(spacing: 0) {
          SimilarQuotationCardHead(index: index, similarQuotation: similarQuotation, trimName: trimName)
          SimilarQuotationCardImage(similarQuotation: similarQuotation, intent: intent)
        }
        .padding(.leading, leadingPadding)
        
      SimilarHMGDataCard(state: state, options: similarQuotation.options, intent: intent)
      }
  }
  
}

