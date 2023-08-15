//
//  InternalColorSelectionHorizontalList.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import SwiftUI

struct ColorSelectionHorizontalList: View {

  var state: [InteriorColorState]
  var height: CGFloat = 400

  var body: some View {
    VStack(alignment: .leading) {
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack {
          ForEach(state.indices, id: \.self) { i in
            InternalColorSelectionView(state: state[i], action: { })
          }
        }
      }
      .frame(maxHeight: height)
    }
  }

}

struct InternalColorSelectionHorizontalList: View {

  var state: [ColorState]
  var height: CGFloat = 400

    var body: some View {
      VStack(alignment: .leading) {
        ScrollView(.horizontal, showsIndicators: false) {
          LazyHStack {
            ForEach(state.indices, id: \.self) { _ in

            }
          }
        }
        .frame(maxHeight: height)
      }
    }

}
