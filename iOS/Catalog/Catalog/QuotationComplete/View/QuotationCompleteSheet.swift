//
//  QuotationCompleteSheet.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/17.
//

 import SwiftUI

 struct QuotationCompleteSheet: View {
    var quotation = Quotation.shared
    var body: some View {
      ScrollView {
        LazyVStack {
          // capsule
          CLSheetCapsule(height: 4)

          // 요약견적 제목
          Text("요약견적").catalogFont(type: .HeadKRMedium16).leadingTitle()

          // 요약 견적
          HStack(spacing: 46) {
            VStack(alignment: .leading, spacing: 1) {
              Text("모델")
                .catalogFont(type: .TextKRRegular12)
                .foregroundColor(Color.gray600)
              Text((quotation.state.quotation?.trim.name ?? ""))
                .catalogFont(type: .HeadKRMedium18)
                .foregroundColor(Color.gray900)
            }
            VStack(alignment: .leading, spacing: 1) {
              Text("평균연비")
                .catalogFont(type: .TextKRRegular12)
                .foregroundColor(Color.gray600)
              Text("2,199cc")
                .catalogFont(type: .HeadKRMedium18)
                .foregroundColor(Color.gray900)
            }
            VStack(alignment: .leading, spacing: 1) {
              Text("배기량")
                .catalogFont(type: .TextKRRegular12)
                .foregroundColor(Color.gray600)
              Text("12km/I")
                .catalogFont(type: .HeadKRMedium18)
                .foregroundColor(Color.gray900)
            }
          }
          .frame(maxWidth: .infinity, minHeight: 95)
          .padding(.horizontal, 21)
          .background(Color.skyBlueCardBG)

          // 상세견적 제목
          Text("상세견적").catalogFont(type: .HeadKRMedium16).leadingTitle()

          // 상세견적
          DetailQuotationList(quotation: quotation.state.quotation?.toSummary() ?? SummaryCarQuotation(
            model: SummaryQuotationInfo(title: "모델", name: "xx", price: CLNumber(0)),
            trim: SummaryQuotationInfo(title: "트림", name: "xx", price: CLNumber(0)),
            powertrain: SummaryQuotationInfo(title: "파워트레인", name: "xx", price: CLNumber(0)),
            bodytype: SummaryQuotationInfo(title: "바디타입", name: "xx", price: CLNumber(0)),
            drivetrain: SummaryQuotationInfo(title: "구동방식", name: "xx", price: CLNumber(0)),
            externalColor: SummaryQuotationInfo(title: "외장색상", name: "xx", price: CLNumber(0)),
            internalColor: SummaryQuotationInfo(title: "내장색상", name: "xx", price: CLNumber(0)),
            options: []))
        }
      }

   }
 }

 struct QuotationCompleteSheet_Previews: PreviewProvider {
    static var previews: some View {
        QuotationCompleteSheet()
    }
 }
