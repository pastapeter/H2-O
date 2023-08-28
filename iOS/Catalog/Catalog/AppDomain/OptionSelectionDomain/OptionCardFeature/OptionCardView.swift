//
//  OptionCardView.swift
//  Catalog
//
//  Created by Jung peter on 8/16/23.
//

import SwiftUI

struct OptionCardView: IntentBindingType {
  
  var container: Container<OptionCardViewIntentType, OptionCardModel.ViewState, OptionCardModel.State>
  var intent: OptionCardViewIntentType { container.intent }
  var viewState: OptionCardModel.ViewState { intent.viewState }
  var state: OptionCardModel.State { intent.state }
  @SwiftUI.State var isModalPresenting = false
  @SwiftUI.State var isSelected: Bool = false


}

extension OptionCardView: View {
  
  var body: some View {
    
    Button {
      intent.send(action: .onTap(option: viewState)) {
        if viewState.price != nil {
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
          choiceRatioView()
          HStack(alignment: .lastTextBaseline) {
            VStack(alignment: .leading, spacing: 0) {
              titleView()
              priceView()
            }
            Spacer()
            if viewState.price != nil {
              optionCheckView()
            }
          }
          Spacer().frame(height: CGFloat(12).scaledHeight)
        }
        .padding(.horizontal, CGFloat(12).scaledHeight)
      }
      .frame(height: CGFloat(212).scaledHeight)
      .optionCardBackground(isSelected: isSelected)
      .cornerRadius(2)
      .CLDialogFullScreenCover(show: $isModalPresenting, content: {
        TransparentZStack {
          if viewState.isPackage {
            ModalPopUpComponent(state: self.viewState.packageOption, submitAction: {
              intent.send(action: .onTap(option: self.viewState)) {
                self.isSelected.toggle()
                self.isModalPresenting.toggle()
              }
            }) { _ in
              OptionModalTabContentView(state: self.viewState.packageOption)
            }
          } else {
            ModalPopUpComponent(state: self.viewState.defaultOptionDetail, submitAction: {
              intent.send(action: .onTap(option: self.viewState)) {
                self.isSelected.toggle()
                self.isModalPresenting.toggle()
              }
            }) { _ in
              OptionModalContentView(state: self.viewState.defaultOptionDetail)
            }
          }
        }
      })
    }
    .buttonStyle(EmptyButtonStyle())
    
  }
  
}

// MARK: - Private View
extension OptionCardView {
  
  @ViewBuilder
  private func choiceRatioView() -> some View {
    if let choiceRatio = viewState.choiceRatio {
      Text("\(Text("\(choiceRatio.description)%").foregroundColor(.activeBlue2))가 선택했어요")
        .foregroundColor(.gray500)
        .catalogFont(type: .TextKRMedium12)
    } else {
      Text(" ")
        .foregroundColor(.gray500)
        .catalogFont(type: .TextKRMedium12)
    }
  }
  
  @ViewBuilder
  private func priceView() -> some View {
    
    Text(viewState.price?.signedWon ?? "기본포함")
      .foregroundColor(.gray900)
      .catalogFont(type: .TextKRMedium14)
    
  }
  
  @ViewBuilder
  private func titleView() -> some View {
    Text(viewState.name)
      .catalogFont(type: .HeadKRMedium16)
      .multilineTextAlignment(.leading)
      .foregroundColor(.gray900)
  }
  
  @ViewBuilder
  private func optionCheckView() -> some View {
    
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
  
  @ViewBuilder
  private func optionImageView() -> some View {
    
    ZStack {
      AsyncCachedImage(url: viewState.imageURL) { image in
        image.resizable()
      }
      VStack(spacing: 0) {
        HStack {
          Spacer()
          if viewState.containsHmgData {
            HMGButton(action: {
              intent.send(action: .onTapDetail) {
                isModalPresenting.toggle()
              }
            })
          } else {
            Button(action: {
              
              intent.send(action: .onTapDetail) {
                isModalPresenting.toggle()
              }
              
            }) {
              Text("상세보기")
                .catalogFont(type: .TextKRMedium12)
            }
            .buttonStyle(DetailButtonStyle())
          }
        }
        Spacer()
        HStack {
          ForEach(viewState.hashTags.indices, id: \.self) { i in
            ImageTagView(title: viewState.hashTags[i])
          }
          Spacer()
        }
      }
      .padding(.leading, 13)
      .padding(.bottom, 8)
    }
  }
  
}

// MARK: - Builder
extension OptionCardView {
  
  @ViewBuilder
  static func build(intent: OptionCardViewIntent) -> some View {
    OptionCardView(container: .init(intent: intent,
                                    viewState: intent.viewState,
                                    state: intent.state,
                                    modelChangePublisher: intent.objectWillChange))
  }
  
}

// MARK: - Private Modifier
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
