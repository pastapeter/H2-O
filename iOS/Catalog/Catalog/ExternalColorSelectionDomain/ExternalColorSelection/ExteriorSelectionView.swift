//
//  ExternalSelectionView.swift
//  Catalog
//
//  Created by Jung peter on 8/14/23.
//

import SwiftUI

struct ExteriorSelectionView: IntentBindingType {

  @StateObject var container: Container<ExteriorSelectionIntentType, ExteriorSelectionModel.State>

  var intent: ExteriorSelectionIntentType {
    container.intent
  }

  var viewState: ExteriorSelectionModel.State {
    intent.viewState
  }

}

extension ExteriorSelectionView: View {

  var body: some View {
    ScrollView {
      VStack {
        ProgressView()
          .frame(height: CGFloat(292).scaledHeight)
        Spacer().frame(height: CGFloat(20).scaledHeight)
        VStack(alignment: .leading, spacing: 0) {
          Text("외장 색상을 선택해주세요")
            .catalogFont(type: .HeadKRMedium18)
          Spacer().frame(height: 8)
          ExteriorColorSelectionHorizontalList(state: viewState.colors,
                                               intent: intent,
                                               height: UIScreen.main.bounds.height * 183 / 812
          )
          Spacer()
        }
        .padding(.leading, 20)
      }
    }
    .onAppear {
      intent.send(action: .onAppear)
    }
  }

}

extension ExteriorSelectionView {

  @ViewBuilder
  static func build(intent: ExteriorSelectionIntent) -> some View {
    ExteriorSelectionView(container: .init(intent: intent,
                                                    state: intent.viewState,
                                                    modelChangePublisher: intent.objectWillChange))
  }

}

struct ExternalSelectionContainerView_Previews: PreviewProvider {
    static var previews: some View {
      ExteriorSelectionView.build(intent: .init(initialState: .init(selectedTrimId: 123),
                                                         repository: MockExteriorRepository()))
    }
}
