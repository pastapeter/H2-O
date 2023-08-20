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

    @SwiftUI.State var isFloatingExpanded: Bool = false
}

extension CLBudgetRangeView {
    var budgetPriceBinding: Binding<CLNumber> {
        .init(get: { state.budgetPrice },
              set: { intent.send(action: .budgetChanged(newBudgetPrice: $0)) })
    }
    var isExceedBudgetBinding: Binding<Bool> {
        .init(get: { state.isExceedBudget },
              set: { _ in intent.send(action: .exceedBudgetChanged) })
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
            Text(state.status == .similarQuotation ? "유사견적 가격" : "예산 범위")
              .catalogFont(type: .HeadKRMedium14)
              .foregroundColor(Color.gray50)
            Spacer()
          }
          HStack(spacing: 8) {
            Spacer()
            Text(attributedString)
              .catalogFont(type: .TextKRRegular12)
            if state.status != .similarQuotation {
              Button {
                isFloatingExpanded.toggle()
              } label: {
                isFloatingExpanded ? Image("arrow_up") : Image("arrow_down")
              }
              .buttonStyle(.plain)
            }
          }
        }
        .padding(.top, CGFloat(9.5).scaledHeight)
        .padding(.bottom, isFloatingExpanded ? CGFloat(15.5).scaledHeight : CGFloat(8.5).scaledHeight)

        if isFloatingExpanded {
          // MARK: - 슬라이더
          switch state.status {
            case .`default`, .complete:
              CLSliderView(intent: intent,
                           minimumBudget: state.minimumPrice,
                           maximumBudget: state.maximumPrice,
                           currentQuotationPrice: state.currentQuotationPrice,
                           status: state.status,
                           budgetPriceBinding: budgetPriceBinding,
                           isExceedBudget: isExceedBudgetBinding)
            case .similarQuotation:
              CLSimilarQuotationSlideView(minimumBudget: state.minimumPrice,
                                          maximumBudget: state.maximumPrice,
                                          currentQuotationPrice: state.currentQuotationPrice,
                                          similarQuotationPrice: CLNumber(41000000))
          }
          // MARK: - 확인 버튼
          if state.status == .complete {
            CLSimilarQuotationButton(isExceedBudget: isExceedBudgetBinding, intent: intent)
          }
        }
      }
      .padding(.horizontal, 16)
      .background(state.isExceedBudget ? Color("ExceedBudgetColor") : Color.primary700)
      .cornerRadius(10)
      Spacer()
    }
    .padding(.horizontal, 12)
    .padding(.top, CGFloat(12).scaledHeight)
    .onAppear {
      intent.send(action: .onAppear)
      if state.status == .similarQuotation || state.status == .complete {
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
            modelChangePublisher: intent.objectWillChange))
    }
}

extension CLBudgetRangeView {
    var attributedString: AttributedString {
        let headString = ((state.status == .similarQuotation) ? "내 견적 " : "설정한 예산") +
      ((!state.isExceedBudget && (state.status == .default)) ? "까지 " : "보다 ")
        let budgetString = state.budgetGap.won
        let tailString = (state.isExceedBudget ?
                          "더 들었어요" : (state.status == .default) ? "남았어요" : (state.status == .complete) ? "아꼈어요" : "비싸요")
        var text = AttributedString(headString + budgetString + " " + tailString + ".")
        guard let range = text.range(of: budgetString ) else { return "" }
        text.foregroundColor = Color.gray50
        text[range].font = UIFont(name: "HyundaiSansText-Medium", size: 12)
        text[range].foregroundColor = state.isExceedBudget ? Color.sand : Color.activeBlue2
        return text
    }
}

// struct CLBudgetRangeView_Previews: PreviewProvider {
//    static var previews: some View {
//        CLBudgetRangeView.build(
//            intent: CLBudgetRangeIntent(initialState: .init(
//              currentQuotationPrice: CLNumber(40000000),
//              budgetPrice: CLNumber(40750000),
//              status: .default), navigationIntent: <#CLNavigationIntentType#>
//            )
//        )
//    }
// }
