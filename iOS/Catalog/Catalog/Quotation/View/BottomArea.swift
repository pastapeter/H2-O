//
//  BottomArea.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/13.
//

import SwiftUI

struct BottomArea {
  @Binding var showQuotationSummarySheet: Bool
  @StateObject var quotation = Quotation.shared
  var intent: CLNavigationIntentType
}

extension BottomArea: View {
    var body: some View {
      VStack {
        CLQuotationPriceBar(showQuotationSummarySheet:
                                $showQuotationSummarySheet,
                            currentQuotationPrice: quotation.state.totalPrice, buttonText: "견적 요약")
        CLDualChoiceButton(leftText: "이전",
                           rightText: "다음",
                           height: 52,
                           leftAction: { intent.send(action: .onTapNavTab(index: intent.state
                            .currentPage - 1)) },
                           rightAction: { intent.send(action: .onTapNavTab(index: intent.state
                            .currentPage + 1)) })
      }
    }
}
