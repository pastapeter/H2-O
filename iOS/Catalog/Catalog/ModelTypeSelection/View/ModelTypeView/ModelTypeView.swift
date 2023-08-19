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
      VStack {
        ZStack(alignment: .topTrailing) {
          AsyncImage(url: state.imageURL) { image in
            image
              .resizable()
              .frame(maxWidth: CGFloat(UIScreen.main.bounds.width - 32).scaledWidth, maxHeight: CGFloat(130).scaledHeight)
          } placeholder: {
            ProgressView()
          }
          HMGButton {
            intent.send(action: .onTapDetailButton(isPresenting: !state.isModalPresenting))
          }
          
        }
        Spacer().frame(height: 8)
        ModelTypeButtonContainer(intent: intent, options: state.optionStates)
        .padding(.horizontal, 4)
        .padding(.bottom, 4)
      }
      .background(Color.gray50)
      .cornerRadius(8)
    }
    .CLDialogFullScreenCover(show: isModalPresenting) {
      CarouselModalPopUpComponent(modalContentItems: state.modelTypeDetailState, selectedId: state.selectedId ,submitAction: { id in
        intent.send(action: .onTapOptions(id: id))
        intent.send(action: .onTapDetailButton(isPresenting: !state.isModalPresenting))
        // TODO 가격 추가하기
      }, content: { detailState in
        ModelContentView(state: detailState)
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
