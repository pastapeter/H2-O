//
//  ContentView.swift
//  Catalog
//
//  Created by Jung peter on 8/1/23.
//

import SwiftUI

struct ContentView: View {
    @State var showPopUp: Bool = true
    @State var showQuotationSummarySheet: Bool = false
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                CLNavigationView.build(intent: CLNavigationIntent(initialState: .init(currentPage: 1)))
                CLQuotationPriceBar(showQuotationSummarySheet:
                                        $showQuotationSummarySheet,
                                    currentQuotationPrice: .constant(CLPrice(43560000)), buttonText: "견적 요약")
                CLDualChoiceButton(leftText: "이전", rightText: "다음", height: 52, leftAction: { print("이전 버튼 클릭") }, rightAction: { print("다음 버튼 클릭") })
            }
            .sheet(isPresented: $showQuotationSummarySheet) {
                CLQuotationSummarySheet(quotation: CarQuotation(), showQuotationSummarySheet: $showQuotationSummarySheet)
            }
            .padding(.bottom, 0.1)
            if showPopUp {
                CLPopUp(   showPopUp: $showPopUp,
                           padding: EdgeInsets(top: 244, leading: 33, bottom: 332, trailing: 86),
                           rectangleImage: "guide_popup_rectangle",
                           width: 214,
                           height: 236,
                           title: "현대자동차만이\n제공하는 실활용 데이터로\n합리적인 차량을 만들어 보세요.",
                           accentText: "실활용 데이터",
                           description: "HMG Data 마크는 Hyundai Motor Group\n에서만 제공하는 데이터입니다.\n주행 중 운전자들이 실제로 얼마나 활용하는지를\n추적해 수치화한 데이터 입니다.")
            }

            if showQuotationSummarySheet {
                DimmedZStack {}
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
