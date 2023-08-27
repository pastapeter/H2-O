//
//  SimilarQuotationHelpView.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/20.
//

import SwiftUI

struct SimilarQuotationHelpView: View {
  @Binding var showAlert: Bool
  var intent: SimilarQuotationIntentType
  var body: some View {
    VStack {
      DimmedZStack {
        VStack(spacing: 0) {
          Spacer().frame(height: CGFloat(70).scaledHeight)
          HStack(spacing: 0) {
            Spacer().frame(width: CGFloat(118).scaledWidth)
            CLPopUp(paddingEdge: .top,
                    rectangleImage: "similar_quide_popup",
                    width: CGFloat(250).scaledWidth,
                    height: CGFloat(155.5).scaledHeight,
                    title: "내 견적과 비슷한 실제 출고 견적들을\n확인하고 비교해보세요.",
                    accentText: "내 견적과 비슷한 실제 출고 견적",
                    description: "유사 견적이란, 내 견적과 해시태그 유사도가\n높은 다른 사람들의 실제 출고 견적이에요.",
                    cancelAction: { },
                    hasCancelButton: false)
            .frame(alignment: .bottomTrailing)
          }
          Spacer()
        }
        HelpIcon(intent: intent, showAlert: $showAlert)
        Button {
          showAlert = false
        } label: {
          Color.clear.ignoresSafeArea()
        }
      }
    }
  }
}
