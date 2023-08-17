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
          LeadingTitle(title: "요약견적")

          // 요약 견적
          HStack(spacing: 46) {
            VStack(alignment: .leading, spacing: 1) {
              Text("모델")
                .catalogFont(type: .TextKRRegular12)
                .foregroundColor(Color.gray600)
              Text((quotation.state.quotation?.trim.name ?? "") + "(르블랑)" )
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

          LeadingTitle(title: "상세견적")
          DetailQuotationList()
        }
      }

    }
}

struct QuotationCompleteSheet_Previews: PreviewProvider {
    static var previews: some View {
        QuotationCompleteSheet()
    }
}
