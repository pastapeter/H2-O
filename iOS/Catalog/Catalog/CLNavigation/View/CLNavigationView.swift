//
//  NavigationView.swift
//  Catalog
//
//  Created by Jung peter on 8/2/23.
//

import SwiftUI

struct CLNavigationView: IntentBindingType {
  @StateObject var container: Container<CLNavigationIntentType, CLNavigationModel.State>
  var intent: CLNavigationIntentType { container.intent }
  var state: CLNavigationModel.State { intent.state }
  let mockImageName: [String] = ["trim", "modelType", "external", "internal", "option", "complete"]
  var quotation = Quotation.shared
  @SwiftUI.State var menuStatus: [CLNavigationMenuTitleView.Status] = [.inactive,
                                                                       .inactive,
                                                                       .inactive,
                                                                       .inactive,
                                                                       .inactive,
                                                                       .inactive]
  @SwiftUI.State var showQuotationSummarySheet: Bool = false
}

extension CLNavigationView {
  var currentPageBinding: Binding<Int> {
    .init(get: { state.currentPage },
          set: { intent.send(action: .onTapNavTab(index: $0)) })
  }
  
  var showQuotationSummarySheetBinding: Binding<Bool> {
    .init(get: { state.showQuotationSummarySheet },
          set: {_ in })
  }
}

extension CLNavigationView: View {
  var body: some View {
    ZStack {
      NavigationView {
        VStack(spacing: 0) {
          
          CLTopNaviBar(intent: intent)
          CLNavigationMenuView(currentPage: currentPageBinding, menuStatus: menuStatus, navigationMenuTitles: ["트림", "타입", "외장", "내장", "옵션", "완료"])
          ZStack {
            TabView(selection: currentPageBinding) {
              
              TrimSelectionView.build(intent: TrimSelectionIntent(
                initialState: .init(
                  carId: 1),
                repository: TrimSelectionRepository(), quotation: Quotation.shared, navigationIntent: intent))
              .tag(0)
              ModelTypeSelectionView.build(intent: .init(initialState: .init(), repository: ModelTypeRepository(modelTypeRequestManager: RequestManager(apiManager: APIManager()))))
                .tag(1)
              ExternalSelectionView.build(
                intent: .init(initialState: .init(selectedTrimId: 2),
                              repository: ExteriorColorRepository(
                                requestManager: RequestManager(
                                  apiManager: ExteriorColorAPIManager()))))
              .tag(2)
              InteriorColorSelectionView.build(
                intent: .init(initialState: .init(selectedTrimID: 2,
                                                  selectedColorId: 1,
                                                  trimColors: []),
                              repository: InteriorColorSelectionRepository(
                                requestManager: RequestManager(
                                  apiManager: InteriorAPIManager()))))
              .tag(3)
              OptionSelectionView.build(intent: .init(initialState: .init(currentPage: 0,
                                                                          additionalOptionState: .init(cardStates: [], selectedFilterId: 0),
                                                                          defaultOptionState: .init(cardStates: [], selectedFilterId: 0)), repository: OptionSelectionRepository(requestManager: RequestManager(apiManager: OptionSelectionAPIManager()), trimID: 2))).tag(4)
              QuotationCompleteView.build(intent: .init(initialState: .init(summaryQuotation: SummaryCarQuotation.mock(), technicalSpec: .init(displacement: CLNumber(0), fuelEfficiency: 0.0), nextNavIndex: 0, alertCase: .delete(id: 0), showSheet: false, showAlert: false, alertTitle: ""), repository: QuotationCompleteRepository(quotationCompleteRequestManager: RequestManager(apiManager: APIManager())), quotationService: Quotation.shared, navigationIntent: intent) )
                .tag(5)
            }
            .onAppear { UIScrollView.appearance().isScrollEnabled = false }
            .tabViewStyle(.page(indexDisplayMode: .never))
            if state.currentPage != 0 && state.currentPage != 5 {
              CLBudgetRangeView.build(
                intent: CLBudgetRangeIntent(initialState:
                    .init(
                      currentQuotationPrice: quotation.state.totalPrice,
                      budgetPrice: (quotation.state.maxPrice + quotation.state.minPrice) / CLNumber(2),
                      status: .default), navigationIntent: intent)
              )
            } else if state.currentPage == 5 {
              CLBudgetRangeView.build(
                intent: CLBudgetRangeIntent(initialState:
                    .init(currentQuotationPrice: quotation.state.totalPrice,
                          budgetPrice: (quotation.state.maxPrice + quotation.state.minPrice) / CLNumber(2),
                          status: .complete), navigationIntent: intent))
            }
          }
          if state.currentPage != 0 {
            QuotationFooter.build(intent: .shared,
                                  prevAction: { intent.send(action: .onTapNavTab(index: state.currentPage - 1))},
                                  nextAction: { intent.send(action: .onTapNavTab(index: state.currentPage + 1))},
                                  currentPage: currentPageBinding)
          }
          
          NavigationLink(destination:     SimilarQuotationView.build(intent: .init(initialState: .init(currentSimilarQuotationIndex: 0, similarQuotations: [SimilarQuotation.mock(),
                                                                                                                                                            SimilarQuotation.mock(),
                                                                                                                                                            SimilarQuotation.mock()], selectedOptions: [], alertCase: .noOption, showAlert: false), repository: SimilarQuotationMockRepository(), navigationIntent: self.intent, budgetRangeIntent: CLBudgetRangeIntent(initialState: .init(currentQuotationPrice: quotation.state.totalPrice, budgetPrice: .init(0), status: .similarQuotation), navigationIntent: CLNavigationIntent(initialState: .init(currentPage: 5, showQuotationSummarySheet: false, alertCase: .guide, showAlert: false)))), navitationIntent: intent),
                         isActive: showQuotationSummarySheetBinding,
                         label: { Text("") })
        }
        .sheet(isPresented: $showQuotationSummarySheet) {
          CLQuotationSummarySheet(currentQuotationPrice: quotation.state.totalPrice,
                                  summaryQuotation: quotation.state.quotation?.toSummary() ?? SummaryCarQuotation.mock(),
                                  showQuotationSummarySheet: $showQuotationSummarySheet)
          
          
        }
      }
      if state.showAlert {
        makeAlertView(alertCase: state.alertCase)
      }
    }

  }
  
}

extension CLNavigationView {
  @ViewBuilder
  static func build(intent: CLNavigationIntent) -> some View {
    CLNavigationView(container: .init(
      intent: intent as CLNavigationIntent,
      state: intent.state,
      modelChangePublisher: intent.objectWillChange))
  }
}

struct CLNavigationView_Previews: PreviewProvider {
  static var previews: some View {
    return CLNavigationView.build(intent: CLNavigationIntent(initialState: .init(currentPage: 0, showQuotationSummarySheet: false, alertCase: .guide, showAlert: false)))
  }
}

extension ShapeStyle where Self == Color {
  static var random: Color {
    Color(
      red: .random(in: 0...1),
      green: .random(in: 0...1),
      blue: .random(in: 0...1)
    )
  }
}
