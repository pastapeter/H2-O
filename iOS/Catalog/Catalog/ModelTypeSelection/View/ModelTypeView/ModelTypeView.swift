//
//  ModelTypeView.swift
//  Catalog
//
//  Created by Jung peter on 8/11/23.
//

import SwiftUI

struct ModelTypeView: IntentBindingType {

  @StateObject var container: Container<ModelTypeIntentType, ModelTypeModel.State>
  var intent: ModelTypeIntentType { container.intent }
  var state: ModelTypeModel.State { intent.state }
}

extension ModelTypeView {

  private var isModalPresenting: Binding<Bool> {
    .init(get: { state.isModalPresenting && !state.modelTypeDetailState.isEmpty },
          set: { intent.send(action: .onTapDetailButton(isPresenting: $0)) })
  }

}

extension ModelTypeView: View {

  var body: some View {
    VStack(alignment: .leading) {
      Text(state.title)
        .catalogFont(type: .HeadKRMedium18)
      Spacer().frame(height: 8)
      ZStack(alignment: .topTrailing) {
        HMGButton {
          intent.send(action: .onTapDetailButton(isPresenting: !state.isModalPresenting))
        }
        VStack {
          Spacer().frame(height: 12)
          Image("powertrain")
          Spacer().frame(height: 8)
          ModelTypeButtonContainer(intent: intent, options: state.optionStates)
          .padding(.horizontal, 4)
          .padding(.bottom, 4)
        }
      }
      .background(Color.gray50)
      .cornerRadius(8)
    }
    .CLDialogFullScreenCover(show: isModalPresenting) {

      ModalPopUpComponent(state: state.modelTypeDetailState[0].content, submitAction: {
        // TODO 가격 추가하기
      }, content: {
        ModelContentView(state: state.modelTypeDetailState[0])
      })
    }
    .padding(.horizontal, 16)
  }

}

extension ModelTypeView {
  @ViewBuilder
  static func build(intent: ModelTypeIntent) -> some View {
    ModelTypeView(container: .init(intent: intent as ModelTypeIntent,
                                   state: intent.state,
                                   modelChangePublisher: intent.objectWillChange))
  }
}

struct ModelTypeView_Previews: PreviewProvider {
    static var previews: some View {
      return ModelTypeView.build(intent: .init(initialState: .init()))
    }
}
