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
}

extension CLNavigationView: View {
  var body: some View {
    VStack {
      CLTopNaviBar(intent: intent)
      CLNavigationMenuView(currentPage: currentPageBinding, menuStatus: menuStatus, navigationMenuTitles: ["트림", "타입", "외장", "내장", "옵션", "완료"])
      ZStack {
        TabView(selection: currentPageBinding) {

          TrimSelectionView.build(intent: TrimSelectionIntent(
            initialState: .init(
              carId: 1),
            repository: TrimSelectionRepository(), quotation: Quotation.shared, navigationIntent: intent)).tag(0)
          ModelTypeSelectionContainerView.build(intent: .init(initialState: .mock(), repository: MockModelTypeRepository())).tag(1)

          ExternalSelectionContainerView.build(
            intent: .init(initialState: .init(selectedTrimId: 2),
                          repository: ExteriorColorRepository(requestManager: RequestManager(apiManager: ExteriorColorAPIManager())))).tag(2)
          InteriorColorSelectionView.build(
            intent: .init(initialState: .init(selectedTrimID: 2, selectedColorId: 1, trimColors: []),
                          repository: InteriorColorSelectionRepository(requestManager: RequestManager(apiManager: InteriorAPIManager())))).tag(3)
          OptionSelectionView.build(intent: .init(initialState: .init(currentPage: 0,
                                                                      additionalOptionState: .init(cardStates: [], selectedFilterId: 0),
                                                                      defaultOptionState: .init(cardStates: [], selectedFilterId: 0)))).tag(4)
          MockView(image: mockImageName[5]).tag(5)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        if state.currentPage != 0 {
          CLBudgetRangeView.build(
            intent: CLBudgetRangeIntent(initialState:
                .init(currentQuotationPrice: quotation.state.totalPrice,
                      budgetPrice: (quotation.state.maxPrice + quotation.state.minPrice) / CLNumber(2)))
          )
        }
      }
      if state.currentPage != 0 {
        BottomArea(showQuotationSummarySheet: $showQuotationSummarySheet, intent: intent)
      }
    }
    .sheet(isPresented: $showQuotationSummarySheet) {
      CLQuotationSummarySheet(currentQuotationPrice: quotation.state.totalPrice, summaryQuotation: quotation.state.quotation?.toSummary() ?? SummaryCarQuotation(
        model: SummaryQuotationInfo(name: "xx", price: CLNumber(0)),
        trim: SummaryQuotationInfo(name: "xx", price: CLNumber(0)),
        powertrain: SummaryQuotationInfo(name: "xx", price: CLNumber(0)),
        bodytype: SummaryQuotationInfo(name: "xx", price: CLNumber(0)),
        drivetrain: SummaryQuotationInfo(name: "xx", price: CLNumber(0)),
        externalColor: SummaryQuotationInfo(name: "xx", price: CLNumber(0)),
        internalColor: SummaryQuotationInfo(name: "xx", price: CLNumber(0)),
        options: []),
                                showQuotationSummarySheet: $showQuotationSummarySheet)
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
    return CLNavigationView.build(intent: CLNavigationIntent(initialState: .init(currentPage: 0)))
  }
}
