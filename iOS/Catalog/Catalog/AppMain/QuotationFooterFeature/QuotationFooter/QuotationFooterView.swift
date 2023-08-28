//
//  QuotationFooterView.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/13.
//

import SwiftUI

struct QuotationFooterView: IntentBindingType {
  @StateObject var container: Container<QuotationFooterIntentType , QuotationFooterModel.ViewState, QuotationFooterModel.State>
  
  var intent: QuotationFooterIntentType { container.intent }
  var state: QuotationFooterModel.State { intent.state }
  var viewState: QuotationFooterModel.ViewState { intent.viewState }
  
  var prevAction: () -> Void
  var nextAction: () -> Void
  
  @Binding private var showQuotationSummarySheet: Bool
  @Binding var currentPage: Int
}


extension QuotationFooterView: View {
  var body: some View {
    VStack {
      if currentPage != 5 {
        CLQuotationPriceBar(
          content: {
            CLCapsuleButton(width: 86, height: 36, text: "견적 요약", action: {
              
              showQuotationSummarySheet = true
              
            })
          },
          quotation: intent.quotation as! Quotation)
        CLDualChoiceButton(leftText: "이전",
                           rightText: "다음",
                           height: 52,
                           leftAction: { prevAction() },
                           rightAction: { nextAction() })
      } else {
        CLQuotationPriceBar(
          content: {
            Text("합리적인 가격으로 완성된\n나만의 팰리세이드가 탄생했어요!")
              .catalogFont(type: .TextKRMedium12)
          }, quotation: intent.quotation as! Quotation)
        CLDualChoiceButton(leftText: "공유하기",
                           rightText: "상담신청",
                           height: 52,
                           leftAction: { intent.send(action: .onTapCompleteButton) },
                           rightAction: { intent.send(action: .onTapCompleteButton) })
      }
      
    }
    .onAppear {
      intent.send(action: .onAppear)
    }
  }
}

extension QuotationFooterView {
  @ViewBuilder
  static func build(intent: QuotationFooterIntent, prevAction: @escaping () -> Void, nextAction: @escaping () -> Void, currentPage: Binding<Int>, showQuotationSummarySheet: Binding<Bool>) -> some View {
    
    QuotationFooterView(container: .init(
      intent: intent, viewState: intent.viewState,
      state: intent.state,
      modelChangePublisher: intent.objectWillChange), prevAction: prevAction, nextAction: nextAction, showQuotationSummarySheet: showQuotationSummarySheet, currentPage: currentPage)
    
  }
}
