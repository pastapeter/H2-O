//
//  CLSliderView.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/07.
//

import SwiftUI

struct CLSliderView: View {

    var intent: CLBudgetRangeIntentType

    let minimumBudget: CLPrice
    let maximumBudget: CLPrice

    @State var currentQuotationPrice: CLPrice
    @State var status: CLBudgetRangeView.Status = .default

    @Binding var budgetPriceBinding: CLPrice
    @Binding var isExceedBudget: Bool

    var body: some View {
        VStack {
            // MARK: - 슬라이더
            GeometryReader { gr in
                let maxCoordinate: CGFloat = gr.size.width - 6
                let minCoordinate: CGFloat = 0
                let scaleFactor = (maxCoordinate - minCoordinate) / CGFloat(maximumBudget.price - minimumBudget.price)

                var currentCoordinate: CGFloat {
                    return CGFloat(currentQuotationPrice.price - minimumBudget.price) * scaleFactor
                }
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: maxCoordinate, height: 6)
                        .foregroundColor(isExceedBudget ? Color.gray800 : Color.primary800)

                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: CGFloat(budgetPriceBinding.price - minimumBudget.price) * scaleFactor, height: 6)
                        .foregroundColor(.white)

                    HStack {
                        (isExceedBudget ? Image("sand_pincette") : Image("blue_pincette"))
                            .offset(x: currentCoordinate, y: -5)
                    }
                    if status == .default {
                        HStack {
                            (isExceedBudget ? Image("sand_slider_icon") : Image("blue_slider_icon"))
                                .offset(x: CGFloat(budgetPriceBinding.price - minimumBudget.price) * scaleFactor - 6)
                                .gesture(
                                    DragGesture(minimumDistance: 0)
                                        .onChanged { v in
                                            if v.translation.width > 0 {
                                                let newCoordinate = min(maxCoordinate, v.location.x)
                                                var newBudget = newCoordinate / scaleFactor + CGFloat(minimumBudget.price)
                                                newBudget = round(newBudget * 0.00001) * 100000
                                                budgetPriceBinding = CLPrice(Int32(newBudget))
                                            } else if v.translation.width < 0 {
                                                let newCoordinate = max(minCoordinate, v.location.x)
                                                var newBudget = newCoordinate / scaleFactor + CGFloat(minimumBudget.price)
                                                newBudget = round(newBudget * 0.00001) * 100000
                                                budgetPriceBinding = CLPrice(Int32(newBudget))
                                            }
                                            intent.send(action: .isChangedBudget(newBudgetPrice: budgetPriceBinding))
                                        }
                                )
                        }
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
        }
        .frame(height: 35)
        .padding(.bottom, 14)
        .onAppear {
            budgetPriceBinding = CLPrice((minimumBudget.price + maximumBudget.price) / 2)
        }
    }
}
