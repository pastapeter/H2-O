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
      .frame(width: CGFloat(141).scaledWidth)
      .overlay(RoundedRectangle(cornerRadius: 2)
        .stroke(isSelected ? Color.activeBlue2 : Color.gray200)
      )
  }
}

struct ExteriorColorSelectionHorizontalList: View {

  var state: [ExteriorColorState]
  var intent: ExteriorSelectionIntentType
  var height: CGFloat = CGFloat(177).scaledHeight

  var body: some View {
      HorizontalScroller(height: height) {
        ForEach(state.indices, id: \.self) { i in
          ColorSelectionView<ExteriorColorDisplayView>.build(action: {
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
