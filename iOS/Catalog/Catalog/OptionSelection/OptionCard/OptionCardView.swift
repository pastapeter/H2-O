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
  @SwiftUI.State var isModalPresenting = false
  @SwiftUI.State var isSelected: Bool = false

  var detailState: ModelTypeDetailState = .init(content: .mock(), hmgData: .mock())

    var body: some View {
      
      Button {
        intent.send(action: .onTap(id: state.id)) {
          if state.price != nil {
            isSelected.toggle()
          } else {
            isSelected = false
          }
        }
      } label: {
        VStack(spacing: 0) {
          optionImageView()
            .frame(height: CGFloat(128).scaledHeight)
          VStack(alignment: .leading, spacing: 0) {
            Spacer().frame(height: CGFloat(12).scaledHeight)
            if let choiceRatio = state.choiceRatio {
              Text("\(Text("\(choiceRatio.description)%").foregroundColor(.activeBlue2))가 선택했어요")
                .foregroundColor(.gray500)
                .catalogFont(type: .TextKRMedium12)
            } else {
              Text(" ")
                .foregroundColor(.gray500)
                .catalogFont(type: .TextKRMedium12)
            }
            HStack(alignment: .lastTextBaseline) {
              VStack(alignment: .leading, spacing: 0) {
                Text(state.name)
                  .catalogFont(type: .HeadKRMedium16)
                  .multilineTextAlignment(.leading)
                  .foregroundColor(.gray900)
                Text(state.price?.signedWon ?? "기본포함")
                  .foregroundColor(.gray900)
                  .catalogFont(type: .TextKRMedium14)
              }
              Spacer()
              if state.price != nil {
                ZStack {
                  Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: CGFloat(40).scaledWidth, height: CGFloat(40).scaledWidth)
                    .background(isSelected ? .activeBlue : Color.gray50)
                    .overlay(
                      RoundedRectangle(cornerRadius: 2)
                        .inset(by: 0.5)
                        .stroke(isSelected ? .activeBlue : Color.gray100, lineWidth: 1))
                  Image("check").renderingMode(.template).foregroundColor(isSelected ? .white : .gray200)
                }
              }
            }
            Spacer().frame(height: CGFloat(12).scaledHeight)
          }
          .padding(.horizontal, CGFloat(12).scaledHeight)
        }
        .frame(height: CGFloat(212).scaledHeight)
        .optionCardBackground(isSelected: isSelected)
        .cornerRadius(2)
        .CLDialogFullScreenCover(show: $isModalPresenting) {
          ModalPopUpComponent(state: detailState.content, submitAction: {
            // TODO 가격 추가하기
          }, content: {
            ModelContentView(state: detailState)
          })
        }
      }
      .buttonStyle(EmptyButtonStyle())
    }

}

extension OptionCardView {
  
  @ViewBuilder
  func optionImageView() -> some View {
    ZStack {
      Image("cooling")
        .resizable()
        .scaledToFill()
        .frame(height: CGFloat(128).scaledHeight)
        .clipped()
      VStack(spacing: 0) {
        HStack {
          Spacer()
          if state.containsHmgData {
            HMGButton(action: {
              intent.send(action: .onTapDetail) {
                isModalPresenting.toggle()
              }
            })
          } else {
            Button(action: {}) {
              Text("상세보기")
                .catalogFont(type: .TextKRMedium12)
            }
            .buttonStyle(DetailButtonStyle())
          }
        }
        Spacer()
        HStack {
          ForEach(state.hashTags.indices, id: \.self) { i in
            ImageTagView(title: state.hashTags[i])
          }
          Spacer()
        }
      }
      .padding(.leading, 13)
      .padding(.bottom, 8)
    }
  }
  
  @ViewBuilder
  static func build(intent: OptionCardViewIntent) -> some View {
    OptionCardView(container: .init(intent: intent,
                                    state: intent.state,
                                    modelChangePublisher: intent.objectWillChange))
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
