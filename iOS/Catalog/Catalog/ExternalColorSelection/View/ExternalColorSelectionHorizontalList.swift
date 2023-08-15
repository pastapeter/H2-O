//
//  ExternalColorSelectionHorizontalList.swift
//  Catalog
//
//  Created by Jung peter on 8/14/23.
//

import SwiftUI

struct CardModifier: ViewModifier {

  var isSelected: Bool

  func body(content: Content) -> some View {
    content
      .frame(width: UIScreen.main.bounds.width * (141 / 375))
      .overlay(RoundedRectangle(cornerRadius: 2)
        .stroke(isSelected ? Color.activeBlue2 : Color.gray200)
      )
  }
}

struct ExternalColorSelectionHorizontalList: View {

  var state: [ExteriorColorState]
  var intent: ExternalSelectionIntentType
  var height: CGFloat = 400

  var body: some View {
    HorizontalScroller(height: height) {
      ForEach(state.indices, id: \.self) { i in
        ColorSelectionView<ExternalColorDisplayView>.build(action: {
          intent.send(action: .onTapColor(id: state[i].color.id))
        }, colorState: state[i].toColorInfoState())
      }
    }
  }
}

fileprivate extension ExteriorColorState {

  func toColorInfoState() -> ColorInfoState {

    return ColorInfoState(isSelected: self.isSelected,
                          id: self.color.id,
                          name: self.color.name,
                          choiceRatio: self.color.choiceRatio,
                          price: self.color.price,
                          colorType: .exterior(hexColor: self.color.hexCode))
  }

}
