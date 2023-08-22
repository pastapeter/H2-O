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
      Spacer().frame(height: CGFloat(50).scaledHeight)
      CLNavigationMenuView(currentPage: currentPage, navigationMenuTitles: state.optionMenuTitle, titleFont: .TextKRBold18, horizontalSpacing: CGFloat(24).scaledWidth, verticalSpacing: 2)
        .padding(.leading, CGFloat(20).scaledWidth)
      
      Spacer().frame(height: 16)
      TabView(selection: currentPage) {
        OptionCardScollView.build(intent: .init(initialState: .init(cardStates: []), repository: intent.repository, parent: intent as? OptionSelectionCollectable)).tag(0)
        OptionCardScollView.build(intent: .init(initialState: .init(filterState: FilterState(filters: OptionCategory.defaultOptionFilter, selectedFilterId: 0) ,cardStates: [], isExtraOptionTab : false), repository: intent.repository, parent: intent as? OptionSelectionCollectable)).tag(1)
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
