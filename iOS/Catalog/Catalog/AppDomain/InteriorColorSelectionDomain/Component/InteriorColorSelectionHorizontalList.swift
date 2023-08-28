//
//  InternalColorSelectionHorizontalList.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import SwiftUI

struct InteriorColorSelectionHorizontalList: View {

  var state: [InteriorColorState]
  var intent: InteriorColorSelectionIntentType
  var height: CGFloat = 400

  var body: some View {
    HorizontalScroller(height: height) {
      ForEach(state.indices, id: \.self) { i in
        ColorSelectionView<InteriorColorDisplayView>.build(action: {
          intent.send(action: .onTapColor(id: state[i].color.id))
        }, colorState: state[i].toColorInfoState())
      }
    }
  }
}

fileprivate extension InteriorColorState {
  func toColorInfoState() -> ColorInfoState {
    return ColorInfoState(isSelected: self.isSelected,
                          id: self.color.id,
                          name: self.color.name,
                          choiceRatio: self.color.choiceRatio,
                          price: self.color.price,
                          colorType: .interior(fabricImageURL: self.color.fabricImageURL,
                                               bannerImageURL: self.color.bannerImageURL))
  }
}
