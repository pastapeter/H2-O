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

  var state: [ColorState]
  var height: CGFloat = 400

    var body: some View {
      VStack(alignment: .leading) {
        ScrollView(.horizontal, showsIndicators: false) {
          LazyHStack {
            ForEach(state.indices, id: \.self) { i in
              ColorSelectionView(state: state[i]) {
                print(i)
              }
            }
          }
        }
        .frame(maxHeight: height)
      }
    }
}

struct ExternalColorSelectionHorizontalList_Previews: PreviewProvider {
    static var previews: some View {
      ExternalColorSelectionHorizontalList(state: [])
    }
}
