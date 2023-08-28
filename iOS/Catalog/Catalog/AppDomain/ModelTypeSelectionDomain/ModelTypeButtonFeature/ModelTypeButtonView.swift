//
//  ModelTypeButtonView.swift
//  Catalog
//
//  Created by Jung peter on 8/11/23.
//

import SwiftUI

struct ModelTypeButtonView: View {

  var state: ModelTypeOptionState
  var action: (Int) -> Void

    var body: some View {
      Button {
        action(state.id)
      } label: {
        VStack(alignment: .leading) {
          if let choiceRatio = state.choiceRatio {
            choiceRatioView(with: choiceRatio.description)
          } else {
            choiceRatioView(with: " ")
          }
          Text(state.title)
            .catalogFont(type: .HeadKRMedium16)
            .foregroundColor(state.isSelected ? .gray900 : .gray600)
          HStack {
            Text(state.price.signedWon)
              .foregroundColor(state.isSelected ? .gray900 : .gray600)
              .catalogFont(type: .TextKRMedium16)
            Spacer()
            Image("check").renderingMode(.template).foregroundColor(state.isSelected ? .activeBlue2 : .gray200)
          }
        }
      }
      .padding(EdgeInsets(top: CGFloat(8).scaledHeight, leading: CGFloat(13).scaledWidth, bottom: CGFloat(7).scaledHeight, trailing: CGFloat(8).scaledWidth))
      .cornerRadius(4)
      .buttonSelected(isselected: state.isSelected)
    }
}

extension ModelTypeButtonView {
  
  @ViewBuilder
  private func choiceRatioView(with ratio: String) -> some View {
    Text("\(Text("\(ratio)%").foregroundColor(state.isSelected ? .activeBlue2 : .gray600))의 선택")
      .foregroundColor(.gray500)
      .catalogFont(type: .HeadKRMedium14)
  }
  
}
