//
//  InternalColorSelectionHorizontalList.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import SwiftUI

struct InternalColorSelectionHorizontalList: View {

  var state: [InteriorColorState]
  var height: CGFloat = 400
  
  var body: some View {
    HorizontalScroller(height: height) {
      ForEach(state.indices, id: \.self) { i in
        InternalColorSelectionView(state: state[i], action: { })
      }
    }
  }
}
