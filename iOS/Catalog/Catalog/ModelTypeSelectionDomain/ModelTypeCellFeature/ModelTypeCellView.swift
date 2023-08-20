//
//  ModelTypeView.swift
//  Catalog
//
//  Created by Jung peter on 8/11/23.
//

import SwiftUI

struct ModelTypeCellView: IntentBindingType {
  
  @StateObject var container: Container<ModelTypeCellIntentType, ModelTypeCellModel.State>
  
  var intent: ModelTypeCellIntentType { container.intent }
  
  var state: ModelTypeCellModel.State { intent.state }
  
}

extension ModelTypeCellView {
  
  private var isModalPresenting: Binding<Bool> {
    .init(get: { state.isModalPresenting && !state.modelTypeDetailState.isEmpty },
          set: { intent.send(action: .onTapDetailButton(isPresenting: $0)) })
  }
  
}

extension ModelTypeCellView: View {
  
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
        ModelTypeModalContentView(state: detailState)
      })
    }
    .padding(.horizontal, 16)
  }

}

extension ModelTypeCellView {
  @ViewBuilder
  static func build(intent: ModelTypeCellIntent) -> some View {
    ModelTypeCellView(container: .init(intent: intent as ModelTypeCellIntent,
                                   state: intent.state,
                                   modelChangePublisher: intent.objectWillChange))
  }
}

struct ModelTypeCellView_Previews: PreviewProvider {
  static var previews: some View {
    return ModelTypeCellView.build(intent: .init(initialState: .init()))
  }
}
