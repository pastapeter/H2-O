//
//  ModelTypeView.swift
//  Catalog
//
//  Created by Jung peter on 8/11/23.
//

import SwiftUI

struct ModelTypeCellView: IntentBindingType {
  
  @StateObject var container: Container<ModelTypeCellIntentType, ModelTypeCellModel.ViewState, ModelTypeCellModel.State>
  
  var intent: ModelTypeCellIntentType { container.intent }
  
  var viewState: ModelTypeCellModel.ViewState { intent.viewState }
  
  var state: ModelTypeCellModel.State { intent.state }
  
}

extension ModelTypeCellView {
  
  private var isModalPresenting: Binding<Bool> {
    .init(get: { viewState.isModalPresenting && !viewState.modelTypeDetailState.isEmpty },
          set: { intent.send(action: .onTapDetailButton(isPresenting: $0)) })
  }
  
}

extension ModelTypeCellView: View {
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(viewState.title)
        .catalogFont(type: .HeadKRMedium18)
      Spacer().frame(height: 8)
      VStack {
        ZStack(alignment: .topTrailing) {
          AsyncCachedImage(url: viewState.imageURL) { image in
            image
              .resizable()
              .frame(maxWidth: CGFloat(UIScreen.main.bounds.width - 32).scaledWidth, maxHeight: CGFloat(130).scaledHeight)
          }
          HMGButton {
            intent.send(action: .onTapDetailButton(isPresenting: !viewState.isModalPresenting))
          }
          
        }
        Spacer().frame(height: 8)
        ModelTypeButtonContainer(intent: intent, options: viewState.optionStates)
        .padding(.horizontal, 4)
        .padding(.bottom, 4)
      }
      .background(Color.gray50)
      .cornerRadius(8)
    }
    .CLDialogFullScreenCover(show: isModalPresenting) {
      CarouselModalPopUpComponent(modalContentItems: viewState.modelTypeDetailState, selectedId: viewState.selectedId ,submitAction: { id in
        intent.send(action: .onTapOptions(id: id))
        intent.send(action: .onTapDetailButton(isPresenting: !viewState.isModalPresenting))
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
                                       viewState: intent.viewState,
                                   state: intent.state,
                                   modelChangePublisher: intent.objectWillChange))
  }
}