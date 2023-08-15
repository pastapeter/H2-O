//
//  InternalColorSelectionContainerView.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import SwiftUI

struct InternalColorSelectionContainerView: View {

  var colors: [InteriorColorState] = [
    .init(isSelected: true, color: .init(id: 123, name: "퀄팅천연(블랙)", choiceRatio: .init(28), price: .init(0))),
    .init(isSelected: true, color: .init(id: 456, name: "쿨그레이", choiceRatio: .init(28), price: .init(0)))
  ]

  var body: some View {
    VStack {
      Rectangle()
        .fill(.blue)
      Spacer().frame(height: 20)
      VStack(alignment: .leading, spacing: 0) {
        Text("내장 색상을 선택해주세요")
          .catalogFont(type: .HeadKRMedium18)
        Spacer().frame(height: 8)
        ColorSelectionHorizontalList(state: colors, height: UIScreen.main.bounds.height * 177 / 812)
        Spacer()
      }
      .padding(.leading, 20)
    }
    .onAppear {
//      intent.send(action: .onAppear)
    }
  }
}
