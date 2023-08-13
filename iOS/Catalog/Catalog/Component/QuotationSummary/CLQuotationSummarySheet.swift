//
//  CLQuotationSummarySheet.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/09.
//

import SwiftUI

struct CLQuotationSummarySheet: View {
    @State var isExternal: Bool = true
    var quotation: CarQuotation

    @Binding var showQuotationSummarySheet: Bool
       var body: some View {
        VStack(spacing: 0) {
            // MARK: - 상단바
            Capsule()
                .fill(Color.gray300)
                .frame(width: 42, height: 4)
                .padding(.bottom, 5)
                .padding(.top, 5)

            ZStack {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        Spacer().frame(height: 14)

                        // MARK: - 취소버튼
                        CLCancelButton(cancelAction: {
                            showQuotationSummarySheet = false
                        }, width: 14, height: 14, padding: EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))

                            // MARK: - 외장/내장 사진
                            ZStack {
                                if isExternal {
                                    VStack {
                                        Image(quotation.externalImage)
                                            .resizable()
                                            .frame(width: 327, height: 160)
                                        Spacer()
                                    }
                                } else {
                                    Image(quotation.internalImage)
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width)
                                }
                                VStack {
                                    Spacer()
                                    CLToggle(isLeft: $isExternal)
                                        .padding(.vertical, 8)
                                }
                                VStack {
                                    CLLinearGradient(height: 29, startPoint: .top, endPoint: .bottom)
                                    Spacer()
                                }
                                Spacer()

                            }
                            .frame(height: 195)

                            Divider().foregroundColor(Color.gray300).padding(.horizontal, 20)

                            // MARK: - 상세 정보 및 가격
                            VStack(spacing: 16) {
                                VStack(spacing: 8) {
                                    CLListText(title: "모델", name: quotation.model.name, price: quotation.model.price)
                                    CLListText(title: "트림", name: quotation.trim.name, price: quotation.trim.price)
                                }
                                Divider().foregroundColor(Color("background2"))
                                VStack(spacing: 8) {
                                    CLListText(title: "파워트레인", name: quotation.powertrain.name, price: quotation.powertrain.price)
                                    CLListText(title: "바디타입", name: quotation.bodyType.name, price: quotation.bodyType.price)
                                    CLListText(title: "구동방식", name: quotation.drivingMethod.name, price: quotation.drivingMethod.price)
                                }
                                Divider().foregroundColor(Color("background2"))
                                VStack(spacing: 8) {
                                    CLListText(title: "외장색상", name: quotation.externalColor.name, price: quotation.externalColor.price)
                                    CLListText(title: "내장색상", name: quotation.internalColor.name, price: quotation.internalColor.price)
                                }
                                Divider().foregroundColor(Color("background2"))
                                VStack(spacing: 8) {
                                    ForEach(0..<quotation.options.count) { idx in
                                        CLListText(title: "옵션", name: quotation.options[idx].name, price: quotation.options[idx].price)
                                    }
                                }
                            }
                            .padding(.vertical, 16)
                            .padding(.horizontal, 20)

                    }
                }

                VStack {
                    Spacer()
                    CLLinearGradient(height: 48, startPoint: .bottom, endPoint: .top)
                }
            }
            CLQuotationPriceBar(showQuotationSummarySheet:
                                    $showQuotationSummarySheet,
                                currentQuotationPrice: .constant(CLNumber(43560000)),
                                buttonText: "요약 닫기")
            CLButton(mainText: "견적 완료하기", height: 52, backgroundColor: Color.primary700) {
                showQuotationSummarySheet = false

            }
            .padding(.bottom, 0.1)
        }

    }
}
