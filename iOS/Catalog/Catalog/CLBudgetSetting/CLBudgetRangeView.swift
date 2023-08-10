//
//  CLBudgetRangeView.swift.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/06.
//

import SwiftUI

struct CLBudgetRangeView: IntentBindingType {
    @StateObject var container: Container<CLBudgetRangeIntentType, CLBudgetRangeModel.State>

    var intent: CLBudgetRangeIntentType { container.intent }
    var state: CLBudgetRangeModel.State { intent.state }

    @SwiftUI.State var status: CLBudgetRangeView.Status = .complete {
        didSet {
            isFloatingExpanded = false
        }
    }

    @SwiftUI.State var isFloatingExpanded: Bool = false

    let minimunBudget: CLPrice
    let maximumBudget: CLPrice
}

extension CLBudgetRangeView {
    var budgetPriceBinding: Binding<CLPrice> {
        .init(get: { state.budgetPrice },
              set: { intent.send(action: .isChangedBudget(newBudgetPrice: $0)) })
    }
    var isExceedBudgetBinding: Binding<Bool> {
        .init(get: { state.isExceedBudget },
              set: { _ in intent.send(action: .isChangedExceedBudget) })
    }
}

extension CLBudgetRangeView {
    enum Status {
        case `default`
        case complete
        case similarQuotation
    }
}

extension CLBudgetRangeView: View {
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                // MARK: - 예산범위 title
                ZStack {
                    HStack {
                        Text(status == .similarQuotation ? "유사견적 가격" : "예산 범위")
                            .catalogFont(type: .HeadKRMedium14)
                            .foregroundColor(Color.gray50)
                        Spacer()
                    }
                    HStack(spacing: 8) {
                        Spacer()
                        Text(attributedString)
                            .catalogFont(type: .TextKRRegular12)
                        if status != .similarQuotation {
                            Button {
                                isFloatingExpanded.toggle()
                            } label: {
                                isFloatingExpanded ? Image("arrow_up") : Image("arrow_down")
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.top, 9.5)
                .padding(.bottom, isFloatingExpanded ? 15.5 : 8.5)

                if isFloatingExpanded {
                    // MARK: - 슬라이더
                    switch status {
                        case .`default`, .complete:
                            CLSliderView(intent: intent,
                                         minimumBudget: CLPrice(38500000),
                                         maximumBudget: CLPrice(43000000),
                                         currentQuotationPrice: state.currentQuotationPrice,
                                         status: status,
                                         budgetPriceBinding: budgetPriceBinding,
                                         isExceedBudget: isExceedBudgetBinding)
                        case .similarQuotation:
                            CLSimilarQuotationSlideView(minimumBudget: CLPrice(38500000),
                                                        maximumBudget: CLPrice(43000000),
                                                        currentQuotationPrice: CLPrice(39000000),
                                                        similarQuotationPrice: CLPrice(41000000))
                    }
                    // MARK: - 확인 버튼
                    if status == .complete {
                        CLSimilarQuotationButton(isExceedBudget: isExceedBudgetBinding)
                    }
                }
            }
            .padding(.horizontal, 16)
            .background(state.isExceedBudget ? Color("ExceedBudgetColor") : Color.primary700)
            .cornerRadius(10)
            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.bottom, 20)
        .onAppear {
            if status == .similarQuotation {
                isFloatingExpanded = true
            }
        }
    }
}

extension CLBudgetRangeView {
    @ViewBuilder
    static func build(intent: CLBudgetRangeIntent) -> some View {
        CLBudgetRangeView(container: .init(
            intent: intent as CLBudgetRangeIntentType,
            state: intent.state,
            modelChangePublisher: intent.objectWillChange),
                          minimunBudget: CLPrice(38500000),
                          maximumBudget: CLPrice(43000000))
    }
}

extension CLBudgetRangeView {
    @available(iOS 15, *)
    var attributedString: AttributedString {
        let headString = ((status == .similarQuotation) ? "내 견적 " : "설정한 예산") + ((!state.isExceedBudget && (status == .default)) ? "까지 " : "보다 ")
        let budgetString = state.budgetGap.description
        let tailString = (state.isExceedBudget ? "더 들었어요" : (status == .default) ? "남았어요" : (status == .complete) ? "아꼈어요" : "비싸요")
        var text = AttributedString(headString + budgetString + " " + tailString + ".")
        guard let range = text.range(of: budgetString ) else { return "" }
        text.foregroundColor = Color.gray50
        text[range].font = UIFont(name: "HyundaiSansText-Medium", size: 12)
        text[range].foregroundColor = state.isExceedBudget ? Color.sand : Color.activeBlue2
        return text
    }
}

struct CLBudgetRangeView_Previews: PreviewProvider {
    static var previews: some View {
        CLBudgetRangeView.build(
            intent: CLBudgetRangeIntent(initialState: .init(currentQuotationPrice: CLPrice(40000000), budgetPrice: CLPrice(40750000)))
        )
    }
}
