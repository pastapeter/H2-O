//
//  ColorSelectionComponent.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import SwiftUI

struct ColorSelectionComponent<ColorContent: View>: View {

  var action: () -> Void
  var state: ColorInfoState
  @ViewBuilder var content: () -> ColorContent

  var body: some View {
    Button {
      action()
    } label: {
      VStack {
        content()
        VStack(alignment: .leading, spacing: 0) {
          if let choiceRatioDesc = state.choiceRatio?.description {
            Text("\(Text(choiceRatioDesc).foregroundColor(state.isSelected ? .activeBlue2 : .gray600))%가 선택했어요")
              .foregroundColor(.gray500)
              .catalogFont(type: .HeadKRMedium14)
          } else {
            Text("")
              .catalogFont(type: .HeadKRMedium14)
          }
          Text(state.name)
            .catalogFont(type: .HeadKRMedium16)
            .multilineTextAlignment(.leading)
            .foregroundColor(state.isSelected ? .gray900 : .gray600)
            .fixedSize(horizontal: false, vertical: true)
            .frame(height: CGFloat(39).scaledHeight, alignment: .topLeading)
          Spacer().frame(height: 6)
          HStack {
            Text(state.price.signedWon)
              .foregroundColor(state.isSelected ? .gray900 : .gray600)
              .catalogFont(type: .TextKRMedium16)
            Spacer()
            Image("check").renderingMode(.template).foregroundColor(state.isSelected ? .activeBlue2 : .gray200)
          }
        }
      }
      .selectedCardStyle(isSelected: state.isSelected)
      .buttonSelected(isselected: state.isSelected)
    }
    .buttonStyle(EmptyButtonStyle())
  }

}

struct EmptyButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
  }
}

extension View {

  @ViewBuilder
  func buttonSelected(isselected: Bool) -> some View {
    if isselected {
      modifier(ModelButtonSelectedBackground())
    } else {
      modifier(ModelButtonUnSelectedBackground())
    }

  }

  @ViewBuilder
  func selectedCardStyle(isSelected: Bool) -> some View {
    modifier(CardModifier(isSelected: isSelected))
  }

}
