//
//  OptionSelectionView.swift
//  Catalog
//
//  Created by Jung peter on 8/16/23.
//

import SwiftUI

struct OptionSelectionView: IntentBindingType {

  @StateObject var container: Container<OptionSelectionIntentType, OptionSelectionModel.State>
  var intent: OptionSelectionIntentType { container.intent }
  var state: OptionSelectionModel.State { intent.state }

  var currentPage: Binding<Int> {
    .init(get: { state.currentPage },
          set: { intent.send(action: .onTapTab(index: $0)) })
  }
}

extension OptionSelectionView: View {

  var body: some View {
    VStack(alignment: .leading) {
      Spacer().frame(height: 50)
      CLNavigationMenuView(currentPage: currentPage, navigationMenuTitles: state.optionMenuTitle, titleFont: .TextKRBold18, horizontalSpacing: 24, verticalSpacing: 2)
        .padding(.leading, 20)
      Spacer().frame(height: 16)
      TabView(selection: currentPage) {
        OptionCardScollView.build(intent: .init(initialState: .mock1())).tag(0)
                                  OptionCardScollView.build(intent: .init(initialState: .mock2())).tag(1)
      }
      .tabViewStyle(.page(indexDisplayMode: .never))
    }

  }

}

extension OptionSelectionView {

  @ViewBuilder
  static func build(intent: OptionSelectionIntent) -> some View {

    OptionSelectionView(container: .init(intent: intent as OptionSelectionIntent, state: intent.state, modelChangePublisher: intent.objectWillChange))
  }

}

struct OptionSelectionView_Previews: PreviewProvider {
    static var previews: some View {
      OptionSelectionView.build(intent: .init(initialState: .init(currentPage: 0,
                                                                  additionalOptionState: .init(cardStates: [], selectedFilterId: 0),
                                                                  defaultOptionState: .init(cardStates: [], selectedFilterId: 1))))
    }
}
