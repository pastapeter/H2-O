//
//  CLQuotationPriceBar.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/09.
//

import SwiftUI

struct CLQuotationPriceBar: View {

    @Binding var showQuotationSummarySheet: Bool
    @State var currentQuotationPrice: CLNumber

    var buttonText: String
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    Button {
                        showQuotationSummarySheet.toggle()
                    } label: {
                        Text(buttonText)
                            .catalogFont(type: .TextKRMedium14)
                            .frame(width: 86, height: 36)
                            .foregroundColor(Color.primary0)
                            .overlay(
                                Capsule(style: .continuous)
                                    .stroke(Color.primary0)
                            )
                    }
                    .buttonStyle(.plain)
                    Spacer()
                }
                .padding(.leading, 20)
                HStack {
                    Spacer()
                    VStack(alignment: .trailing, spacing: 0) {
                        Text("현재 견적 가격")
                            .catalogFont(type: .TextKRRegular12)
                            .foregroundColor(Color.gray700)
                        Text(currentQuotationPrice.wonWithSpacing)
                            .catalogFont(type: .HeadKRMedium20)
                            .foregroundColor(Color.primary0)
                    }
                }
                .padding(.trailing, 20)
                .padding(.vertical, 8)
            }
            .frame(height: 58)
        }
    }
}
