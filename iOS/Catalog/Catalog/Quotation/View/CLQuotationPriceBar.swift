//
//  CLQuotationPriceBar.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/09.
//

import SwiftUI

struct CLQuotationPriceBar<Content>: View where Content: View {
  @Binding var showQuotationSummarySheet: Bool
  var state: QuotationModel.State
  @ViewBuilder let content: Content
}

extension CLQuotationPriceBar {
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                  content
                  Spacer()
                }
                .padding(.leading, 20)
                HStack {
                    Spacer()
                    VStack(alignment: .trailing, spacing: 0) {
                        Text("현재 견적 가격")
                            .catalogFont(type: .TextKRRegular12)
                            .foregroundColor(Color.gray700)
                      Text(state.totalPrice.wonWithSpacing)
                            .catalogFont(type: .HeadKRMedium20)
                            .foregroundColor(Color.primary0)
                    }
                }
                .padding(.trailing, 20)
            }
            .frame(height: 52)
        }
    }
}


