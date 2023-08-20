//
//  SimilarQuotationTopBar.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/19.
//

import SwiftUI

struct SimilarQuotationTopBar: View {
  
  let navigationIntent: CLNavigationIntentType
  var body: some View {
    VStack {
      ZStack {
        HStack {
          Button {
            navigationIntent.send(action: .onTapSimilarQuotationBackButton)
          } label: {
            Image("arrow_left")
          }
          Spacer()
        }
        HStack(alignment: .center) {
          Text("유사견적").catalogFont(type: .HeadKRMedium18)
        }
      }
      .padding(.top, 32)
      .padding(.horizontal, 16)
    }
  }
}
