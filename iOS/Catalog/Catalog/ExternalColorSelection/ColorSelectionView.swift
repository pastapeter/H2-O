//
//  ColorSelectionView.swift
//  Catalog
//
//  Created by Jung peter on 8/14/23.
//

import SwiftUI

struct ColorSelectionView: View {

  @State var isSelected: Bool = true
  var title: String

    var body: some View {
      VStack {
        Spacer().frame(height: 12)
        ZStack {
          Circle()
            .strokeBorder(Color.activeBlue, lineWidth: 4)
          Circle()
            .fill(Color.black)
            .padding(.all, 6)
        }
        VStack(alignment: .leading, spacing: 0) {
          Text("\(Text("38%").foregroundColor(isSelected ? .activeBlue2 : .gray600))의 선택했어요")
            .foregroundColor(.gray500)
            .catalogFont(type: .HeadKRMedium14)
          Text(title)
            .catalogFont(type: .HeadKRMedium16)
            .foregroundColor(isSelected ? .gray900 : .gray600)
            .frame(height: 39, alignment: .topLeading)
          Spacer().frame(height: 6)
          HStack {
            Text("+0원")
              .foregroundColor(isSelected ? .gray900 : .gray600)
              .catalogFont(type: .TextKRMedium16)
            Spacer()
            Image("check").renderingMode(.template).foregroundColor(isSelected ? .activeBlue2 : .gray200)
          }
          Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.bottom, 12)
      }
      .externalColorSelectionCardStyle(isselected: isSelected)
      .buttonSelected(isselected: isSelected)
    }
}

struct ColorSelectionView_Previews: PreviewProvider {
    static var previews: some View {
      ColorSelectionView(title: "어비스 블랙펄")
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

  @ViewBuilder
  func externalColorSelectionCardStyle(isselected: Bool) -> some View {
    modifier(CardModifier(isSelected: isselected))
  }

}
