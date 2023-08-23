//
//  SimilarQuotationView.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/19.
//

import SwiftUI

struct SimilarQuotationView {
  @StateObject var container: Container<SimilarQuotationIntentType, SimilarQuotationModel.State>
  var intent: SimilarQuotationIntentType { container.intent }
  var state: SimilarQuotationModel.State { intent.state }
  
  @SwiftUI.State var showHelp: Bool = false
  @SwiftUI.State var currentIndex: Int = 0 {
    didSet(index) {
      intent.send(action: .currentSimilarQuotationIndexChanged(index: index))
    }
  }
  let budgetPrice: CLNumber = CLNumber(50000000)
  let quotation = Quotation.shared
  let navigationIntent: CLNavigationIntentType
}

extension SimilarQuotationView: View {
  
  var body: some View {
    
    NavigationView {
      ZStack {
        VStack {
          SimilarQuotationTopBar(intent: intent)
          
          CLBudgetRangeView.build(intent:
              .init(initialState:
                  .init(currentQuotationPrice: quotation.state.totalPrice,
                        budgetPrice: budgetPrice,
                        status: .similarQuotation),
                    navigationIntent: navigationIntent))
          
          SnapCarousel(items: state.similarQuotations,
                       spacing: CGFloat(12).scaledWidth,
                       trailingSpace: CGFloat(24).scaledWidth,
                       index: $currentIndex) { similarQuotation in
            GeometryReader { proxy in
              let size = proxy.size
              SimilarQuotationCard(index: 0,
                                   similarQuotation: similarQuotation,
                                   intent: intent,
                                   state: state,
                                   trimName: "Le Blanc")
              .frame(width: size.width, height: size.height)
            }
          }
                       .frame(height: CGFloat(449).scaledHeight)
          
          
          HStack(spacing: 10) {
            ForEach(state.similarQuotations.indices, id: \.self) { index in
              Capsule()
                .fill(currentIndex == index ? Color.primary0 : Color.gray200)
                .frame(width: (currentIndex == index ? 15 : 5), height: 5)
                .scaleEffect((currentIndex == index) ? 1.4 : 1)
                .animation(.spring(), value: currentIndex == index)
            }
          }
          .padding(.bottom, CGFloat(12).scaledHeight)
          
          CLInActiceButton(mainText: "내 견적서에 추가하기",
                           subText: "선택된 옵션\(state.selectedOptions.count)개",
                           inActiveText: "옵션을 선택해 추가해보세요.",
                           height: CGFloat(52).scaledHeight,
                           buttonAction: { intent.send(action: .onTapAddButton)
          })
          .disabled(state.selectedOptions.isEmpty)
        }
        .padding([.top, .bottom], 1)
        
        
        if showHelp {
          SimilarQuotationHelpView()
        }
        
        VStack(alignment: .trailing) {
          HStack(alignment: .top) {
            Spacer()
            Button {
              showHelp.toggle()
            } label: {
              Image("help").frame(width: 24, height: 24)
            }
          }
          Spacer()
        }
        .padding(.top, 32)
        .padding(.horizontal, 16)
      }
      
    }
    //TODO: - Quotation 받아오는 방식 변경하기
    .onAppear { intent.send(action: .onAppear(quotation: quotation.state.quotation!))
      
    }
    .navigationBarBackButtonHidden()
  }
  
}


extension SimilarQuotationView {
  @ViewBuilder
  static func build(intent: SimilarQuotationIntent, navitationIntent: CLNavigationIntentType) -> some View {
    
    SimilarQuotationView(container: .init(
      intent: intent as SimilarQuotationIntent,
      state: intent.state,
      modelChangePublisher: intent.objectWillChange), navigationIntent: navitationIntent)
  }
}


//struct SimilarQuotationView_Previews: PreviewProvider {
//  static var previews: some View {
//    let navigationIntent: CLNavigationIntentType = CLNavigationIntent(initialState: .init(currentPage: 5, showQuotationSummarySheet: true))
//
//    SimilarQuotationView.build(intent: .init(initialState: .init(currentSimilarQuotationIndex: 0, similarQuotations: [SimilarQuotation.mock(),SimilarQuotation.mock()], selectedOptions: []),
//                                             repository: SimilarQuotationRepository(requestManager: RequestManager(apiManager: APIManager())), budgetRangeIntent: CLBudgetRangeIntent(initialState: .init(currentQuotationPrice: .init(0), budgetPrice: .init(0), status: .similarQuotation), navigationIntent: CLNavigationIntent(initialState: .init(currentPage: 0, showQuotationSummarySheet: false)))),
//                               navitationIntent: navigationIntent)
//  }
//}
//
//
