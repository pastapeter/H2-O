//
//  CLSimilarQuotationButton.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/08.
//

import SwiftUI

struct CLSimilarQuotationButton: View {

    @Binding var isExceedBudget: Bool

    var body: some View {
        Button {
            print("유사 출고 견적 확인 페이지로 이동")
        } label: {
            Text(isExceedBudget ? "유사견적 확인" : "유사 출고 견적 확인하기")
                    .catalogFont(type: .HeadKRMedium14)
                    .foregroundColor(isExceedBudget ? Color.white : Color.primary)
                    .frame(maxWidth: .infinity, minHeight: 47)
                    .padding(.horizontal, 16)
                    .background(isExceedBudget ? Color("SimilarQuotationButton_2") : Color("SimilarQuotationButton"))
                    .cornerRadius(2)
                    .padding(.bottom, 13)

        }
    }
}
