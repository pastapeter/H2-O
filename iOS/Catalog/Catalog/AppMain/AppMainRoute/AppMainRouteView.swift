//
//  NavigationView.swift
//  Catalog
//
//  Created by Jung peter on 8/2/23.
//

import SwiftUI

struct AppMainRouteView: IntentBindingType {
  @StateObject var container: Container<AppMainRouteIntentType, AppMainRouteModel.ViewState, AppMainRouteModel.State>
  var intent: AppMainRouteIntentType { container.intent }
  var viewState: AppMainRouteModel.ViewState { intent.viewState }
  var state: AppMainRouteModel.State { intent.state }
  let quotation = Quotation()
  @SwiftUI.State var showQuotationSummarySheet: Bool = false
}

extension AppMainRouteView {
  var currentPageBinding: Binding<Int> {
    .init(get: { viewState.currentPage },
          set: { intent.send(action: .onTapNavTab(index: $0)) })
  }
  
  var showQuotationSummarySheetBinding: Binding<Bool> {
    .init(get: { viewState.showQuotationSummarySheet },
          set: {_ in })
  }
}

extension AppMainRouteView: View {
  var body: some View {
    ZStack {
      NavigationView {
        VStack(spacing: 0) {
          TopNaviBar(intent: intent)
          NavigationMenuView(currentPage: currentPageBinding, navigationMenuTitles: ["트림", "타입", "외장", "내장", "옵션", "완료"], showNavigationDivider: true)
          ZStack {
            carTalogTabView()
            carTalogBudgetView()
          }
          ifTrimSelectionPageShowFooterView()
          navigationLinkToSimilarQuotationView()
        }
      }
      .sheet(isPresented: $showQuotationSummarySheet) {
        makeQuotationSummarySheet()
      }
      if viewState.showAlert {
        makeAlertView(alertCase: viewState.alertCase)
      }
    }
  }
}


extension AppMainRouteView {
  
  func makeQuotationSummarySheet() -> some View {
    CLQuotationSummarySheet(currentQuotationPrice: quotation.totalPrice,
                            summaryQuotation: quotation.quotation.toSummary(),
                            showQuotationSummarySheet: $showQuotationSummarySheet, quotationState: quotation)
  }
  
  @ViewBuilder
  func ifTrimSelectionPageShowFooterView() -> some View {
    if viewState.currentPage != 0 {
      makeFooterView()
    }
  }
  
  func navigationLinkToSimilarQuotationView() -> some View {
    NavigationLink(destination: makeSimilarQuotationView(),
                   isActive: showQuotationSummarySheetBinding,
                   label: { Text("") })
  }
  
  
  @ViewBuilder
  func carTalogBudgetView() -> some View {
    if viewState.currentPage != 0 && viewState.currentPage != 5 {
      CLBudgetRangeView.build(
        intent: CLBudgetRangeIntent(initialState:
            .init(
              currentQuotationPrice: quotation.totalPrice,
              budgetPrice: (quotation.maxPrice + quotation.minPrice) / CLNumber(2),
              status: .default), navigationIntent: intent, quotation: quotation)
      )
    } else if viewState.currentPage == 5 {
      CLBudgetRangeView.build(
        intent: CLBudgetRangeIntent(initialState:
            .init(currentQuotationPrice: quotation.totalPrice,
                  budgetPrice: (quotation.maxPrice + quotation.minPrice) / CLNumber(2),
                  status: .complete), navigationIntent: intent, quotation: quotation))
    }
  }
  
  func carTalogTabView() -> some View {
    TabView(selection: currentPageBinding) {
      
      makeTrimSelectionView()
      makeModelSelectionView()
      makeExteriorView()
      makeInteriorView()
      makeOptionSelectionView()
      makeQuotationCompleteView()
      
    }
    .onAppear { UIScrollView.appearance().isScrollEnabled = false }
    .tabViewStyle(.page(indexDisplayMode: .never))
  }
  
  func makeQuotationCompleteView() -> some View {
    QuotationCompleteView.build(intent: .init(initialState: .init(summaryQuotation: SummaryCarQuotation.mock(), technicalSpec: .init(displacement: CLNumber(0), fuelEfficiency: 0.0), nextNavIndex: 0, alertCase: .delete(id: 0), showSheet: false, showAlert: false, alertTitle: ""), repository: QuotationCompleteRepository(quotationCompleteRequestManager: RequestManager(apiManager: APIManager())), quotation: quotation, navigationIntent: intent) )
      .tag(5)
  }
  
  func makeOptionSelectionView() -> some View {
    
    OptionSelectionView.build(intent: .init(initialState: .init(currentPage: 0,
                                                                additionalOptionState: .init(cardStates: [], selectedFilterId: 0),
                                                                defaultOptionState: .init(cardStates: [], selectedFilterId: 0)), repository: OptionSelectionRepository(requestManager: RequestManager(apiManager: OptionSelectionAPIManager()), trimID: 2), quotation: quotation)).tag(4)
    
  }
  
  func makeSimilarQuotationView() -> some View {
    
    SimilarQuotationView.build(intent: .init(initialState: .init(currentSimilarQuotationIndex: 0, similarQuotations: [], selectedOptions: [], alertCase: .noOption, showAlert: false), repository: SimilarQuotationRepository(requestManager: RequestManager(apiManager: APIManager())), navigationIntent: self.intent, budgetRangeIntent: makeCLBudgetRangeIntent(), quotation: quotation), navitationIntent: intent)
    
  }
  
  
  func makeFooterView() -> some View {
    
    QuotationFooterView.build(intent: QuotationFooterIntent(initialViewState: .init(totalPrice: quotation.totalPrice, summary: quotation.summary()), initialState: .init(),
                                                            repository: QuotationFooterRepository(quotationFooterRequestManager: RequestManager(apiManager: APIManager())),
                                                            quotation: quotation),
                              prevAction: { intent.send(action: .onTapNavTab(index: viewState.currentPage - 1))},
                              nextAction: { intent.send(action: .onTapNavTab(index: viewState.currentPage + 1))},
                              currentPage: currentPageBinding, showQuotationSummarySheet: showQuotationSummarySheetBinding)
  }
  
  func makeTrimSelectionView() -> some View {
    TrimSelectionView.build(intent: TrimSelectionIntent(
      initialState: .init(
        carId: 1),
      repository: TrimSelectionRepository(), quotation: quotation, navigationIntent: intent))
    .tag(0)
  }
  
  func makeModelSelectionView() -> some View {
    ModelTypeSelectionView.build(intent: .init(initialState: .init(), initialViewState: .init(), repository: ModelTypeRepository(modelTypeRequestManager: RequestManager(apiManager: APIManager())), quotation: quotation))
      .tag(1)
  }
  
  func makeInteriorView() -> some View {
    
    InteriorColorSelectionView.build(
      intent: .init(initialState: .init(selectedTrimID: 2,
                                        selectedColorId: 1,
                                        trimColors: []),
                    repository: InteriorColorSelectionRepository(
                      requestManager: RequestManager(
                        apiManager: InteriorAPIManager())), quotation: quotation))
    .tag(3)
    
  }
  
  func makeExteriorView() -> some View {
    
    ExteriorSelectionView.build(
      intent: .init(initialViewState: .init(selectedTrimId: 2),
                    repository: ExteriorColorRepository(
                      requestManager: RequestManager(
                        apiManager: ExteriorColorAPIManager())), quotation: quotation))
    .tag(2)
    
  }
  
  func makeCLBudgetRangeIntent() -> CLBudgetRangeIntent {
    CLBudgetRangeIntent(initialState: .init(currentQuotationPrice: quotation.totalPrice, budgetPrice: .init(0), status: .similarQuotation), navigationIntent: AppMainRouteIntent(initialState: .init(currentPage: 5, showQuotationSummarySheet: false, alertCase: .guide, showAlert: false)), quotation: quotation)
  }
  
  @ViewBuilder
  static func build(intent: AppMainRouteIntent) -> some View {
    AppMainRouteView(container: .init(
      intent: intent as AppMainRouteIntent,
      viewState: intent.viewState,
      state: intent.state,
      modelChangePublisher: intent.objectWillChange))
  }
}

struct AppMainRouteView_Previews: PreviewProvider {
  static var previews: some View {
    return AppMainRouteView.build(intent: AppMainRouteIntent(initialState: .init(currentPage: 0, showQuotationSummarySheet: false, alertCase: .guide, showAlert: false)))
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
