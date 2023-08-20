//
//  SimilarQuotationHelpView.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/20.
//

import SwiftUI

struct SimilarQuotationHelpView: View {
  var body: some View {
    DimmedZStack {
      VStack {
        Spacer().frame(height: CGFloat(94).scaledHeight)
        HStack {
          Spacer()
          CLPopUp(paddingEdge: .top,
                  rectangleImage: "similar_quide_popup",
                  width: CGFloat(250).scaledWidth,
                  height: CGFloat(155.5).scaledHeight,
                  title: "내 견적과 비슷한 실제 출고 견적들을\n확인하고 비교해보세요.",
                  accentText: "내 견적과 비슷한 실제 출고 견적",
                  description: "유사 견적이란, 내 견적과 해시태그 유사도가\n높은 다른 사람들의 실제 출고 견적이에요.",
                  cancelAction: { },
                  hasCancelButton: false)
          .padding(.trailing, CGFloat(16).scaledWidth)
        }
        Spacer()
      }
    }
  }
}

struct SimilarQuotationHelpView_Previews: PreviewProvider {
  static var previews: some View {
    SimilarQuotationHelpView()
  }
}
