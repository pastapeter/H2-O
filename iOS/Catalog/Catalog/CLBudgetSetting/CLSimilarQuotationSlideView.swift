//
//  CLSimilarQuotationSlideView.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/08.
//

import SwiftUI

struct CLSimilarQuotationSlideView: View {

    let minimumBudget: CLPrice
    let maximumBudget: CLPrice

    @State var currentQuotationPrice: CLPrice
    @State var similarQuotationPrice: CLPrice

    var body: some View {
        VStack {
            // MARK: - 슬라이더
            GeometryReader { gr in
                let maxCoordinate: CGFloat = gr.size.width
                let minCoordinate: CGFloat = 0
                let scaleFactor = (maxCoordinate - minCoordinate) / CGFloat(maximumBudget.price - minimumBudget.price)
                var currentCoordinate: CGFloat {
                    return scaleFactor * CGFloat(currentQuotationPrice.price - minimumBudget.price)
                }
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: maxCoordinate, height: 6)
                        .foregroundColor(Color.primary400)
                    HStack {
                        Image("blue_pincette")
                            .offset(x: CGFloat(currentQuotationPrice.price - minimumBudget.price) * scaleFactor, y: -5)
                    }
                    HStack {
                        Image("white_pincette")
                            .offset(x: CGFloat(similarQuotationPrice.price - minimumBudget.price) * scaleFactor, y: -5)
                    }
                }
            }
            // MARK: - 최소 최대 가격 나타내기
            ZStack {
                HStack {
                    Text(minimumBudget.sliderDescription)
                        .catalogFont(type: .TextKRMedium10)
                        .foregroundColor(Color.primary200)
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text(maximumBudget.sliderDescription)
                        .catalogFont(type: .TextKRMedium10)
                        .foregroundColor(Color.primary200)
                }
            }
            // MARK: - 내 견적, 유사 견적 텍스트
            HStack {
                Spacer().frame(width: 104)
                HStack(spacing: 4) {
                    Circle()
                        .fill(Color.activeBlue)
                        .frame(width: 8, height: 8)
                        .padding(.leading, 5)
                    Text("내 견적")
                        .catalogFont(type: .TextKRMedium10)
                        .foregroundColor(Color.activeBlue)
                }
                HStack(spacing: 4) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 8, height: 8)
                        .padding(.leading, 5)
                    Text("유사견적")
                        .catalogFont(type: .TextKRMedium10)
                        .foregroundColor(Color.white)
                }
                Spacer().frame(width: 104)
            }
        }
        .frame(height: 62)
        .padding(.bottom, 9)
    }
}
