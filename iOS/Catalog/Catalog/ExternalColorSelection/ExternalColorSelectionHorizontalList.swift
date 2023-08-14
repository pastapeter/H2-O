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

  var state = ["어비스 블랙펄", "어비스 블랙펄2", "어비스 블랙펄3"]
  var height: CGFloat = 400

    var body: some View {
      VStack(alignment: .leading) {
        ScrollView(.horizontal, showsIndicators: false) {
          LazyHStack {
            ForEach(state, id: \.self) { _ in
              ColorSelectionView(title: "어비스 블랙펄")
            }
          }
        }
        .frame(maxHeight: height)
      }
    }
}

struct ExternalColorSelectionHorizontalList_Previews: PreviewProvider {
    static var previews: some View {
        ExternalColorSelectionHorizontalList()
    }
}
