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
      CLNavigationMenuView(currentPage: currentPageBinding, menuStatus: $menuStatus)
      ZStack {
        TabView(selection: currentPageBinding) {
          TrimSelectionView.build(intent: TrimSelectionIntent(
            initialState: .init(
            selectedTrim: nil,
            vehicleId: 123),
            repository: TrimMockRepository())).tag(0)
          ModelTypeSelectionContainerView.build(intent: .init(initialState: .mock(), repository: MockModelTypeRepository())).tag(1)
          ExternalSelectionContainerView.build(intent: .init(initialState: .init(selectedTrimId: 123), repository: MockExternalRepository())).tag(2)
          InteriorColorSelectionContainerView().tag(3)
          MockView(image: mockImageName[4]).tag(4)
          MockView(image: mockImageName[5]).tag(5)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        if state.currentPage != 0 {
          CLBudgetRangeView.build(
              intent: CLBudgetRangeIntent(initialState:
                  .init(currentQuotationPrice: CLNumber(40000000),
                        budgetPrice: CLNumber(40750000)))
              )
        }
      }
      if state.currentPage != 0 {
        BottomArea(showQuotationSummarySheet: $showQuotationSummarySheet)
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
    return CLNavigationView.build(intent: CLNavigationIntent(initialState: .init(currentPage: 0)))
  }
}
