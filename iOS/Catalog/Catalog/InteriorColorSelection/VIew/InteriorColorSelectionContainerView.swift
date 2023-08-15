//
//  InternalColorSelectionContainerView.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import SwiftUI

struct InteriorColorSelectionContainerView: IntentBindingType {

  @StateObject var container: Container<InteriorColorSelectionIntentType, InteriorColorSelectionModel.State>

  var intent: InteriorColorSelectionIntentType {
    container.intent
  }

  var state: InteriorColorSelectionModel.State {
    intent.state
  }

}

extension InteriorColorSelectionContainerView: View {

  var body: some View {
    VStack {
      Rectangle()
        .fill(.blue)
      Spacer().frame(height: 20)
      VStack(alignment: .leading, spacing: 0) {
        Text("내장 색상을 선택해주세요")
          .catalogFont(type: .HeadKRMedium18)
        Spacer().frame(height: 8)
        InteriorColorSelectionHorizontalList(state: state.trimColors,
                                             intent: self.intent,
                                             height: UIScreen.main.bounds.height * 177 / 812)
        Spacer()
      }
      .padding(.leading, 20)
    }
    .onAppear {
      intent.send(action: .onAppear)
    }
  }

}

extension InteriorColorSelectionContainerView {

  @ViewBuilder
  static func build(intent: InteriorColorSelectionIntent) -> some View {
    InteriorColorSelectionContainerView(container: .init(intent: intent,
                                                         state: intent.state,
                                                         modelChangePublisher: intent.objectWillChange))
  }

}
