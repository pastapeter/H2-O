//
//  ExternalSelectionView.swift
//  Catalog
//
//  Created by Jung peter on 8/14/23.
//

import SwiftUI

struct ExternalSelectionContainerView: IntentBindingType {

  @StateObject var container: Container<ExternalSelectionIntentType, ExternalSelectionModel.State>

  var intent: ExternalSelectionIntentType {
    container.intent
  }

  var state: ExternalSelectionModel.State {
    intent.state
  }

}

extension ExternalSelectionContainerView: View {

  var body: some View {
    VStack {
    ProgressView()
    .frame(height: CGFloat(292).scaledHeight)
      Spacer().frame(height: CGFloat(20).scaledHeight)
      VStack(alignment: .leading, spacing: 0) {
        Text("외장 색상을 선택해주세요")
          .catalogFont(type: .HeadKRMedium18)
        Spacer().frame(height: 8)
        ExternalColorSelectionHorizontalList(state: state.colors,
                                             intent: intent)
        Spacer()
      }
      .padding(.leading, 20)
    }
    .onAppear {
      intent.send(action: .onAppear)
    }
  }

}

extension ExternalSelectionContainerView {

  @ViewBuilder
  static func build(intent: ExternalSelectionIntent) -> some View {
    ExternalSelectionContainerView(container: .init(intent: intent,
                                                    state: intent.state,
                                                    modelChangePublisher: intent.objectWillChange))
  }

}

struct ExternalSelectionContainerView_Previews: PreviewProvider {
    static var previews: some View {
      ExternalSelectionContainerView.build(intent: .init(initialState: .init(selectedTrimId: 123),
                                                         repository: MockExternalRepository()))
    }
}
