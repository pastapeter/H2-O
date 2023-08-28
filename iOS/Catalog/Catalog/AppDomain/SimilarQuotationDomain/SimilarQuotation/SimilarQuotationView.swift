//
//  SimilarQuotationView.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/19.
//

import SwiftUI

struct SimilarQuotationView {
  @StateObject var container: Container<SimilarQuotationIntentType, SimilarQuotationModel.ViewState, SimilarQuotationModel.State>
  
  var intent: SimilarQuotationIntentType { container.intent }
  var state: SimilarQuotationModel.State { intent.state }
  var viewState: SimilarQuotationModel.ViewState { intent.viewState}
  
  @SwiftUI.State var currentIndex: Int = 0
  let budgetPrice: CLNumber = CLNumber(50000000)
  let navigationIntent: AppMainRouteIntentType
}

extension SimilarQuotationView {
  var showAlertBinding: Binding<Bool> {
    .init(get: { viewState.showAlert } ,
          set: { bool in intent.send(action: .showAlertChanged(showAlert: bool)) })
  }
  
  var isSelectedOptionsEmpty: Binding<Bool> {
    .init(get: { !viewState.selectedOptions.isEmpty },
          set: { _ in })
  }
}

extension SimilarQuotationView: View {
  
  var body: some View {
    
    NavigationView {
      ZStack {
        VStack {
          SimilarQuotationTopBar(showAlert: showAlertBinding, intent: intent)
          
          CLBudgetRangeView.build(intent:
              .init(initialState:
                  .init(currentQuotationPrice: intent.quotation.totalPrice,
                        budgetPrice: budgetPrice,
                        status: .similarQuotation),
                    navigationIntent: navigationIntent, quotation: intent.quotation as! CLBudgetPriceService))
          
          SnapCarousel(items: viewState.similarQuotations,
                       spacing: CGFloat(12).scaledWidth,
                       trailingSpace: CGFloat(24).scaledWidth,
                       index: $currentIndex) { similarQuotation in
            GeometryReader { proxy in
              let size = proxy.size
              SimilarQuotationCard(index: $currentIndex,
                                   similarQuotation: similarQuotation,
                                   intent: intent,
                                   state: state,
                                   trimName: "Le Blanc")
              .frame(width: size.width, height: size.height)
            }
          }
                       .frame(height: CGFloat(449).scaledHeight)
                       .onChange(of: currentIndex) { newValue in
                         intent.send(action: .currentSimilarQuotationIndexChanged(index: newValue))
                       }
          
          ScrollIndicator(spacing: 10,
                          count: viewState.similarQuotations.count,
                          bigWidth: 15,
                          smallWidth: 5,
                          height: 5,
                          bigScaleEffect: 1.4,
                          smallScaleEffect: 1,
                          bottomPadding: 12,
                          currentIndex: $currentIndex)
          
          CLInActiceButton(mainText: "내 견적서에 추가하기",
                           isEnabled: isSelectedOptionsEmpty,
                           subText: "선택된 옵션\(viewState.selectedOptions.count)개",
                           inActiveText: "옵션을 선택해 추가해보세요.",
                           height: CGFloat(52).scaledHeight,
                           buttonAction: {  intent.send(action: .onTapAddButton(title: viewState.selectedOptions[0].name, count: viewState.selectedOptions.count)) })
        }
        HelpIcon(intent: intent, showAlert: showAlertBinding)
      }
      .onAppear {
        intent.send(action: .onAppear(quotation: intent.quotation.quotation))
      }
    }
    .CLDialogFullScreenCover(show: showAlertBinding) {
      switch viewState.alertCase {
        case .noOption:
          noOptionAlertView()
        case .optionButQuit:
          optionButQuitAlertView()
        case .addOption(let title, let count):
          addOptionAlertView(title: title, count: count)
        case .help:
          SimilarQuotationHelpView(showAlert: showAlertBinding, intent: intent)
      }
    }
    .navigationBarBackButtonHidden()
  }
  
}


extension SimilarQuotationView {
  @ViewBuilder
  static func build(intent: SimilarQuotationIntent, navitationIntent: AppMainRouteIntentType) -> some View {
    SimilarQuotationView(container: .init(
      intent: intent as SimilarQuotationIntent, viewState: intent.viewState, state: intent.state,
      modelChangePublisher: intent.objectWillChange), navigationIntent: navitationIntent)
  }
}

