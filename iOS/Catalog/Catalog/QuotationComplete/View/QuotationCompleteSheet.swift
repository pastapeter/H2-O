//
//  QuotationCompleteSheet.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/17.
//

import SwiftUI

struct QuotationCompleteSheet {
  @Environment(\.presentationMode) var presentationMode
  var state: QuotationCompleteModel.State
  var modelName: String
  var quotation = Quotation.shared
  var intent: QuotationCompleteIntentType
}
extension QuotationCompleteSheet: View {
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
            Text(modelName)
              .catalogFont(type: .HeadKRMedium18)
              .foregroundColor(Color.gray900)
          }
          VStack(alignment: .leading, spacing: 1) {
            Text("평균연비")
              .catalogFont(type: .TextKRRegular12)
              .foregroundColor(Color.gray600)
            Text("\(state.technicalSpec.displacement.description)cc")
              .catalogFont(type: .HeadKRMedium18)
              .foregroundColor(Color.gray900)
          }
          VStack(alignment: .leading, spacing: 1) {
            Text("배기량")
              .catalogFont(type: .TextKRRegular12)
              .foregroundColor(Color.gray600)
            Text("\(state.technicalSpec.fuelEfficiency.description)km/I")
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
        DetailQuotationList(intent: intent, state: intent.state)
        
        Button {
          presentationMode.wrappedValue.dismiss()
        } label: {
          Capsule()
            .fill(Color("ImageCheckCapsule"))
            .frame(width: CGFloat(76).scaledWidth, height: CGFloat(28).scaledHeight)
            .overlay(
              Text("이미지 확인")
                .catalogFont(type: .TextKRMedium12)
                .foregroundColor(.white)
            )
        }
      }
    }
    
  }
}
