//
//  SimilarQuotationView.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/19.
//

import SwiftUI

extension SimilarQuotationView {
  @ViewBuilder
  static func build(intent: SimilarQuotationIntent, navitationIntent: CLNavigationIntentType) -> some View {
    
    SimilarQuotationView(container: .init(
      intent: intent as SimilarQuotationIntent,
      state: intent.state,
      modelChangePublisher: intent.objectWillChange), navigationIntent: navitationIntent)
  }
}

struct SimilarQuotationView {
  @StateObject var container: Container<SimilarQuotationIntentType, SimilarQuotationModel.State>
  var intent: SimilarQuotationIntentType { container.intent }
  var state: SimilarQuotationModel.State { intent.state }
  
  @SwiftUI.State var currentIndexBinding: Int = 0
  @SwiftUI.State var showHelp: Bool = false
  let budgetPrice: CLNumber = CLNumber(50000000)
  let quotation = Quotation.shared
  let navigationIntent: CLNavigationIntentType
  
}

extension SimilarQuotationView: View {
  
  var body: some View {
    
    NavigationView {
      
    
      ZStack {
        
        VStack {
          SimilarQuotationTopBar(navigationIntent: navigationIntent)
          
          CLBudgetRangeView.build(intent:
              .init(initialState:
                  .init(currentQuotationPrice: quotation.state.totalPrice, budgetPrice: budgetPrice,
                        status: .similarQuotation),
                    navigationIntent: navigationIntent))
          
          SnapCarousel(items: state.similarQuotations,
                       spacing: CGFloat(16).scaledWidth,
                       trailingSpace: CGFloat(32).scaledWidth,
                       index: $currentIndexBinding) { trim in
            GeometryReader { proxy in
              let size = proxy.size
              SimilarQuotationCard(intent: intent, index: currentIndexBinding, trimName: "Le Blanc")
                .frame(width: size.width, height: size.height)
            }
          }
          .frame(height: CGFloat(449).scaledHeight)
          
          // TODO: -
          HStack(spacing: 10) {
            ForEach(state.similarQuotations.indices, id: \.self) { index in
              Capsule()
                .fill(currentIndexBinding == index ? Color.primary0 : Color.gray200)
                .frame(width: (currentIndexBinding == index ? 15 : 5), height: 5)
                .scaleEffect((currentIndexBinding == index) ? 1.4 : 1)
                .animation(.spring(), value: currentIndexBinding == index)
            }
          }
          .padding(.bottom, CGFloat(12).scaledHeight)
          
          CLInActiceButton(mainText: "내 견적서에 추가하기",
                           isInactive: !(state.selectedOption.isEmpty),
                           subText: "선택된 옵션\(state.selectedOption.count)개",
                           inActiveText: "옵션을 선택해 추가해보세요.",
                           height: CGFloat(52).scaledHeight,
                           buttonAction: { intent.send(action: .onTapAddButton) })
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
    .navigationBarBackButtonHidden()
  }
  
}

struct SimilarQuotationView_Previews: PreviewProvider {
  static var previews: some View {
    let navigationIntent: CLNavigationIntentType = CLNavigationIntent(initialState: .init(currentPage: 5, showQuotationSummarySheet: true))
    
    SimilarQuotationView.build(intent: .init(initialState: .init(similarQuotations: [SimilarQuotation.mock(),
                                                                                     SimilarQuotation.mock(),
                                                                                     SimilarQuotation.mock()], selectedOption: [])),
                               navitationIntent: navigationIntent)
  }
}
