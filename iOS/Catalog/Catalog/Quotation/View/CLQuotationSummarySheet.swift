//
//  CLQuotationSummarySheet.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/09.
//

import SwiftUI

struct CLQuotationSummarySheet: View {
  @State var isExternal: Bool = true
  @State var currentQuotationPrice: CLNumber
  var summaryQuotation: SummaryCarQuotation
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
                  AsyncImage(url: summaryQuotation.externalImage) { image in
                    image
                      .resizable()
                      .frame(maxWidth: 327, maxHeight: 160)
                  } placeholder: {
                    EmptyView()
                  }
                  Spacer()
                }
              } else {
                AsyncImage(url: summaryQuotation.internalImage) { image in
                  image
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width)
                } placeholder: {
                  EmptyView()
                }
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
                CLListText(title: "모델", info: summaryQuotation.model)
                CLListText(title: "트림", info: summaryQuotation.trim)
              }
              Divider().foregroundColor(Color("background2"))
              VStack(spacing: 8) {
                CLListText(title: "파워트레인", info: summaryQuotation.powertrain)
                CLListText(title: "바디타입", info: summaryQuotation.bodytype)
                CLListText(title: "구동방식", info: summaryQuotation.drivetrain)
              }
              Divider().foregroundColor(Color("background2"))
              VStack(spacing: 8) {
                CLListText(title: "외장색상", info: summaryQuotation.externalColor)
                CLListText(title: "내장색상", info: summaryQuotation.internalColor)
              }
              Divider().foregroundColor(Color("background2"))
              VStack(spacing: 8) {
                let count: Int = summaryQuotation.options.count
                ForEach(0..<count) { idx in
                  CLListText(title: "옵션", info: summaryQuotation.options[idx])
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
                          currentQuotationPrice: currentQuotationPrice,
                          buttonText: "요약 닫기")
      CLButton(mainText: "견적 완료하기", height: 52, backgroundColor: Color.primary700) {
        showQuotationSummarySheet = false

      }
      .padding(.bottom, 0.1)
    }

  }
}
