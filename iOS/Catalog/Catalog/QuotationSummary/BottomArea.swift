//
//  BottomArea.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/13.
//

import SwiftUI

struct BottomArea {
  @Binding var showQuotationSummarySheet: Bool
}

extension BottomArea: View {
    var body: some View {
      VStack {
        CLQuotationPriceBar(showQuotationSummarySheet:
                                $showQuotationSummarySheet,
                            currentQuotationPrice: .constant(CLNumber(41500000)), buttonText: "견적 요약")
        CLDualChoiceButton(leftText: "이전", rightText: "다음", height: 52, leftAction: { print("이전 버튼 클릭") }, rightAction: { print("다음 버튼 클릭") })
      }

    }
}
