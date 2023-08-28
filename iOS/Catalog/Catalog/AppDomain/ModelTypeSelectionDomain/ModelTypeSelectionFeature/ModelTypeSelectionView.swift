//
//  ModelTypeSelectionContainerView.swift
//  Catalog
//
//  Created by Jung peter on 8/11/23.
//

import SwiftUI

struct ModelTypeSelectionView: IntentBindingType {

  @StateObject var container: Container<ModelTypeSelectionIntentType, ModelTypeSelectionModel.ViewState, ModelTypeSelectionModel.State>

  var intent: ModelTypeSelectionIntentType {
    container.intent
  }
  
  var viewState: ModelTypeSelectionModel.ViewState {
    intent.viewState
  }
  
  var state: ModelTypeSelectionModel.State {
    intent.state
  }
  
}

extension ModelTypeSelectionView: View {

  var body: some View {
    ScrollView {
      ZStack {
        LazyVStack(alignment: .leading) {
          Spacer().frame(height: 72)
          Text("모델타입을 선택해주세요")
            .catalogFont(type: .HeadKRMedium18)
            .padding(.horizontal, 16)
          ForEach(viewState.modelTypeStateArray, id: \.self) { state in
            ModelTypeCellView.build(intent: .init(initialState: state)) { intent.send(action: .getSelectedOption(title: $0, option: $1))
            }
          }
          Spacer().frame(height: 38)
          HMGDataBannerComponent {
            FuelEfficiencyAverageBannerView.build(intent: .init(initialState: viewState.fuelEfficiencyAverageState, repository: intent.repository, quotation: intent.quotation))
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

extension ModelTypeSelectionView {
  @ViewBuilder
  static func build(intent: ModelTypeSelectionIntent) -> some View {
    ModelTypeSelectionView(container:
        .init(intent: intent, viewState: intent.viewState, state: intent.state, modelChangePublisher: intent.objectWillChange))
  }
}

