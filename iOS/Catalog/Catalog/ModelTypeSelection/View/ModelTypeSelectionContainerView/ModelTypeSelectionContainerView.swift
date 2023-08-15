//
//  ModelTypeSelectionContainerView.swift
//  Catalog
//
//  Created by Jung peter on 8/11/23.
//

import SwiftUI

struct ModelTypeSelectionContainerView: IntentBindingType {

  @StateObject var container: Container<ModelTypeSelectionContainerIntentType, ModelTypeSelectionContainerModel.State>

  var intent: ModelTypeSelectionContainerIntentType {
    container.intent
  }
  var state: ModelTypeSelectionContainerModel.State {
    intent.state
  }

}

extension ModelTypeSelectionContainerView: View {

  var body: some View {
    ScrollView {
      ZStack {
        LazyVStack(alignment: .leading) {
          Text("모델타입을 선택해주세요")
            .catalogFont(type: .HeadKRMedium18)
            .padding(.horizontal, 16)
          ForEach(state.modelTypeStateArray, id: \.self) { state in
            ModelTypeView.build(intent: .init(initialState: state))
          }
          Spacer().frame(height: 38)
          HMGDataBannerComponent {
            FuelEfficiencyAverageBannerView(state: state.fuelEfficiencyAverageState)
          }
        }
      }
    }
    .frame(maxWidth: .infinity)
    .onAppear {
      intent.send(action: .onAppear)
    }
  }

}

extension ModelTypeSelectionContainerView {
  @ViewBuilder
  static func build(intent: ModelTypeSelectionContainerIntent) -> some View {
    ModelTypeSelectionContainerView(container:
        .init(intent: intent, state: intent.state, modelChangePublisher: intent.objectWillChange))
  }
}

struct ModelTypeSelectionContainerView_Previews: PreviewProvider {
  static var previews: some View {
    return ModelTypeSelectionContainerView.build(intent: .init(initialState: .mock(), repository: MockModelTypeRepository()))
  }
}
