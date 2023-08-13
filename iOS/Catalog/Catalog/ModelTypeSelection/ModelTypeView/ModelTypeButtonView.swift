//
//  ModelTypeButtonView.swift
//  Catalog
//
//  Created by Jung peter on 8/11/23.
//

import SwiftUI

struct ModelTypeButtonView: View {

  var state: OptionState
  var action: (UUID) -> Void

    var body: some View {
      Button {
        action(state.id)
      } label: {
        VStack(alignment: .leading) {
          Text("\(Text("\(state.frequency)%").foregroundColor(state.isSelected ? .activeBlue2 : .gray600))의 선택")
            .foregroundColor(.gray500)
            .catalogFont(type: .HeadKRMedium14)
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
      .padding(EdgeInsets(top: 8, leading: 13, bottom: 7, trailing: 8))
      .cornerRadius(4)
      .buttonSelected(isselected: state.isSelected)
    }
}

struct ModelTypeButtonView_Previews: PreviewProvider {
    static var previews: some View {
      ModelTypeButtonView(state: .init(id: .init()), action: { _ in print("Hello") })
    }
}

fileprivate extension View {

  @ViewBuilder
  func buttonSelected(isselected: Bool) -> some View {
    if isselected {
      modifier(ModelButtonSelectedBackground())
    } else {
      modifier(ModelButtonUnSelectedBackground())
    }

  }

}
