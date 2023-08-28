//
//  ExternalSelectionView.swift
//  Catalog
//
//  Created by Jung peter on 8/14/23.
//

import SwiftUI

struct ExteriorSelectionView: IntentBindingType {

<<<<<<< HEAD
  @StateObject var container: Container<ExteriorSelectionIntentType, ExteriorSelectionModel.ViewState, ExteriorSelectionModel.State>

  var intent: ExteriorSelectionIntentType { container.intent }
  var state: ExteriorSelectionModel.State { intent.state }

  var viewState: ExteriorSelectionModel.ViewState { intent.viewState}
=======
  @StateObject var container: Container<ExteriorSelectionIntentType, ExteriorSelectionModel.State>

  var intent: ExteriorSelectionIntentType {
    container.intent
  }

  var state: ExteriorSelectionModel.State {
    intent.state
  }
>>>>>>> dev-ios

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
<<<<<<< HEAD
          ExteriorColorSelectionHorizontalList(state: viewState.colors,
=======
          ExteriorColorSelectionHorizontalList(state: state.colors,
>>>>>>> dev-ios
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
<<<<<<< HEAD
    ExteriorSelectionView(container: .init(intent: intent, viewState: intent.viewState,
=======
    ExteriorSelectionView(container: .init(intent: intent,
>>>>>>> dev-ios
                                                    state: intent.state,
                                                    modelChangePublisher: intent.objectWillChange))
  }

}
<<<<<<< HEAD
=======

struct ExternalSelectionContainerView_Previews: PreviewProvider {
    static var previews: some View {
      ExteriorSelectionView.build(intent: .init(initialState: .init(selectedTrimId: 123),
                                                         repository: MockExteriorRepository()))
    }
}
>>>>>>> dev-ios
