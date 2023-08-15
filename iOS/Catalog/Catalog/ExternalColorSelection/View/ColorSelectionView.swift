//
//  ColorSelectionView.swift
//  Catalog
//
//  Created by Jung peter on 8/14/23.
//

import SwiftUI

struct ColorSelectionView: View {

  var state: ColorState
  var action: () -> Void

    var body: some View {
      Button {
        action()
      } label: {
        VStack {
          Spacer().frame(height: 12)
          ZStack {
            Circle()
              .strokeBorder(state.isSelected ? Color.activeBlue : .gray100, lineWidth: 4)
            Circle()
              .fill(Color(hex: state.color.hexCode))
              .padding(.all, 6)
          }
          VStack(alignment: .leading, spacing: 0) {
            Text("\(Text(state.color.choiceRatio.description).foregroundColor(state.isSelected ? .activeBlue2 : .gray600))%가 선택했어요")
              .foregroundColor(.gray500)
              .catalogFont(type: .HeadKRMedium14)
            Text(state.color.name)
              .catalogFont(type: .HeadKRMedium16)
              .multilineTextAlignment(.leading)
              .foregroundColor(state.isSelected ? .gray900 : .gray600)
              .fixedSize(horizontal: false, vertical: true)
              .frame(height: 39, alignment: .topLeading)
            Spacer().frame(height: 6)
            HStack {
              Text(state.color.price.signedWon)
                .foregroundColor(state.isSelected ? .gray900 : .gray600)
                .catalogFont(type: .TextKRMedium16)
              Spacer()
              Image("check").renderingMode(.template).foregroundColor(state.isSelected ? .activeBlue2 : .gray200)
            }
            Spacer()
          }
          .padding(.horizontal, 12)
          .padding(.bottom, 12)
        }
        .externalColorSelectionCardStyle(isselected: state.isSelected)
        .buttonSelected(isselected: state.isSelected)
      }
      .buttonStyle(EmptyButtonStyle())
    }
}

struct ColorSelectionView_Previews: PreviewProvider {
    static var previews: some View {
      ColorSelectionView(state: .init(isSelected: true, color: .init(id: 123, name: "어비스 블랙펄", choiceRatio: CLNumber.init(38), price: .init(0), hexCode: "ffffff")), action: { })
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
  func externalColorSelectionCardStyle(isselected: Bool) -> some View {
    modifier(CardModifier(isSelected: isselected))
  }

}
