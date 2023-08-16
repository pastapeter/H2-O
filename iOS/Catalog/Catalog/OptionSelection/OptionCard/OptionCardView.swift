//
//  OptionCardView.swift
//  Catalog
//
//  Created by Jung peter on 8/16/23.
//

import SwiftUI

struct OptionCardView: View {

  var choiceRatioExist: Bool = true
  var isSelected: Bool = false
  @State var isModalPresenting = false
  var detailState: ModelTypeDetailState = .init(content: .mock(), hmgData: .mock())
  var name: String = "컴포트2"
  var price = CLNumber(1090000)

    var body: some View {
      VStack(spacing: 0) {
        ZStack {
          Image("cooling")
            .resizable()
          VStack(spacing: 0) {
            HStack {
              Spacer()
              HMGButton(action: {
                isModalPresenting.toggle()
              })
            }
            Spacer()
            HStack {
              ImageTagView(title: "캠핑")
              ImageTagView(title: "장거리운행")
              ImageTagView(title: "겨울운전")
              Spacer()
            }
          }
          .padding(.leading, 13)
          .padding(.bottom, 8)
        }
        VStack(alignment: .leading, spacing: 0) {
          Spacer().frame(height: 12)
          if choiceRatioExist {
            Text("\(Text("38%").foregroundColor(.activeBlue2))가 선택했어요")
              .foregroundColor(.gray500)
              .catalogFont(type: .TextKRMedium12)
          } else {
            Text("")
              .catalogFont(type: .TextKRMedium12)
          }

          HStack(alignment: .lastTextBaseline) {
            VStack(alignment: .leading, spacing: 0) {
              Text(name)
                .catalogFont(type: .HeadKRMedium16)
                .multilineTextAlignment(.leading)
                .foregroundColor(.gray900)
              Text(price.signedWon)
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
      .CLDialogFullScreenCover(show: $isModalPresenting) {
        ModalPopUpComponent(state: detailState.content, submitAction: {
          // TODO 가격 추가하기
        }, content: {
          ModelContentView(state: detailState)
        })
      }
    }

}

struct OptionCardView_Previews: PreviewProvider {
    static var previews: some View {
        OptionCardView()
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
