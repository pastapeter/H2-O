//
//  OptionCardView.swift
//  Catalog
//
//  Created by Jung peter on 8/16/23.
//

import SwiftUI

struct OptionCardView: IntentBindingType, View {
  
  var container: Container<OptionCardViewIntentType, OptionCardModel.State>
  var intent: OptionCardViewIntentType { container.intent }
  var state: OptionCardModel.State { intent.state }
  
  private var isModalPresenting: Binding<Bool> {
    .init(get: { state.isModalPresenting }, set: {
      intent.send(action: .onTapDetail(isPresenting: $0))
    })
  }
  
  
  var isSelected: Bool = false
  var detailState: ModelTypeDetailState = .init(content: .mock(), hmgData: .mock())


    var body: some View {
      VStack(spacing: 0) {
        ZStack {
          Image("cooling")
            .resizable()
          VStack(spacing: 0) {
            HStack {
              Spacer()
              HMGButton(action: {
                intent.send(action: .onTapDetail(isPresenting: !state.isModalPresenting))
              })
            }
            Spacer()
            HStack {
              ForEach(state.hashTag.indices, id: \.self) { i in
                ImageTagView(title: state.hashTag[i])
              }
              Spacer()
            }
          }
          .padding(.leading, 13)
          .padding(.bottom, 8)
        }
        VStack(alignment: .leading, spacing: 0) {
          Spacer().frame(height: 12)
          Text("\(Text("\(state.info.frequency)%").foregroundColor(.activeBlue2))가 선택했어요")
            .foregroundColor(.gray500)
            .catalogFont(type: .TextKRMedium12)

          HStack(alignment: .lastTextBaseline) {
            VStack(alignment: .leading, spacing: 0) {
              Text(state.info.title)
                .catalogFont(type: .HeadKRMedium16)
                .multilineTextAlignment(.leading)
                .foregroundColor(.gray900)
              Text(state.info.price.signedWon)
                .foregroundColor(.gray900)
                .catalogFont(type: .TextKRMedium14)
            }
            Spacer()
            ZStack {
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 40, height: 40)
                .background(isSelected ? .activeBlue : Color.gray50)
                .overlay(
                  RoundedRectangle(cornerRadius: 2)
                    .inset(by: 0.5)
                    .stroke(isSelected ? .activeBlue : Color.gray100, lineWidth: 1))
              Image("check").renderingMode(.template).foregroundColor(isSelected ? .white : .gray200)
            }
          }
          Spacer().frame(height: 12)
        }
        .padding(.horizontal, 12)
      }
      .frame(height: UIScreen.main.bounds.height * 212 / 812)
      .optionCardBackground(isSelected: isSelected)
      .cornerRadius(2)
      .CLDialogFullScreenCover(show: isModalPresenting) {
        ModalPopUpComponent(state: detailState.content, submitAction: {
          // TODO 가격 추가하기
        }, content: {
          ModelContentView(state: detailState)
        })
      }
    }

}

extension OptionCardView {
  
  @ViewBuilder
  static func build(intent: OptionCardViewIntent) -> some View {
    OptionCardView(container: .init(intent: intent,
                                    state: intent.state,
                                    modelChangePublisher: intent.objectWillChange))
  }
  
}

struct OptionCardView_Previews: PreviewProvider {
    static var previews: some View {
      OptionCardView.build(intent: .init(initialState: .init(hashTag: ["캠핑", "캠핑", "캠핑"], info: .mock())))
    }
}

fileprivate extension View {

  @ViewBuilder
  func optionCardBackground(isSelected: Bool) -> some View {
    if isSelected {
      modifier(ModelButtonSelectedBackground())
    } else {
      modifier(OptionCardUnSelectedBackground())
    }
  }

}

private struct OptionCardUnSelectedBackground: ViewModifier {

  func body(content: Content) -> some View {
    content
      .background(Color.background2)
  }
}
