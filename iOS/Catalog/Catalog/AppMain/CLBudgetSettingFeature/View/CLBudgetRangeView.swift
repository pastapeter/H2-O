//
//  CLBudgetRangeView.swift.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/06.
//

import SwiftUI

struct CLBudgetRangeView: IntentBindingType {
  @StateObject var container: Container<CLBudgetRangeIntentType, CLBudgetRangeModel.ViewState, CLBudgetRangeModel.State>
  
  var intent: CLBudgetRangeIntentType { container.intent }
  var state: CLBudgetRangeModel.State { intent.state }
  var viewState: CLBudgetRangeModel.ViewState { intent.viewState }
  
  @SwiftUI.State var isFloatingExpanded: Bool = false
}

extension CLBudgetRangeView {
  var budgetPriceBinding: Binding<CLNumber> {
    .init(get: { viewState.budgetPrice },
          set: { intent.send(action: .budgetChanged(newBudgetPrice: $0)) })
  }
  
  var isExceedBudgetBinding: Binding<Bool> {
    .init(get: { viewState.isExceedBudget },
          set: { _ in intent.send(action: .exceedBudgetChanged) })
  }
  
  var currentQuotationPriceBinding: Binding<CLNumber> {
    .init(get: { viewState.currentQuotationPrice }, set: { _ in })
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
            Text(viewState.status == .similarQuotation ? "유사견적 가격" : "예산 범위")
              .catalogFont(type: .HeadKRMedium14)
              .foregroundColor(Color.gray50)
            Spacer()
          }
          HStack(spacing: 8) {
            Spacer()
            Text(attributedString)
              .catalogFont(type: .TextKRRegular12)
            if viewState.status != .similarQuotation {
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
          switch viewState.status {
          case .`default`, .complete:
            CLSliderView(intent: intent,
                         minimumBudget: viewState.minimumPrice,
                         maximumBudget: viewState.maximumPrice,
                         currentQuotationPrice: currentQuotationPriceBinding,
                         status: viewState.status,
                         budgetPriceBinding: budgetPriceBinding,
                         isExceedBudget: isExceedBudgetBinding)
          case .similarQuotation:
            CLSimilarQuotationSlideView(minimumBudget: viewState.minimumPrice,
                                        maximumBudget: viewState.maximumPrice,
                                        currentQuotationPrice: viewState.currentQuotationPrice,
                                        similarQuotationPrice: CLNumber(41000000))
          }
          // MARK: - 확인 버튼
          if viewState.status == .complete {
            CLSimilarQuotationButton(isExceedBudget: isExceedBudgetBinding, intent: intent)
          }
        }
      }
      .padding(.horizontal, 16)
      .background(viewState.isExceedBudget ? Color("ExceedBudgetColor") : Color.primary700)
      .cornerRadius(10)
      Spacer()
    }
    .padding(.horizontal, 12)
    .padding(.top, CGFloat(12).scaledHeight)
    .onAppear {
      intent.send(action: .onAppear)
      if viewState.status == .similarQuotation || viewState.status == .complete {
        isFloatingExpanded = true
      } else {
        isFloatingExpanded = false
      }
    }
  }
}


extension CLBudgetRangeView {
  @ViewBuilder
  static func build(intent: CLBudgetRangeIntent) -> some View {
    CLBudgetRangeView(container: .init(
      intent: intent as CLBudgetRangeIntentType,
      viewState: intent.viewState,
      state: intent.state,
      modelChangePublisher: intent.objectWillChange))
  }
}

extension CLBudgetRangeView {
  var attributedString: AttributedString {
    let headString = ((viewState.status == .similarQuotation) ? "내 견적 " : "설정한 예산") +
    ((!viewState.isExceedBudget && (viewState.status == .default)) ? "까지 " : "보다 ")
    let budgetString = viewState.budgetGap.won
    let tailString = (viewState.isExceedBudget ?
                      "더 들었어요" : (viewState.status == .default) ? "남았어요" : (viewState.status == .complete) ? "아꼈어요" : "비싸요")
    var text = AttributedString(headString + budgetString + " " + tailString + ".")
    guard let range = text.range(of: budgetString ) else { return "" }
    text.foregroundColor = Color.gray50
    text[range].font = UIFont(name: "HyundaiSansText-Medium", size: 12)
    text[range].foregroundColor = viewState.isExceedBudget ? Color.sand : Color.activeBlue2
    return text
  }
}

