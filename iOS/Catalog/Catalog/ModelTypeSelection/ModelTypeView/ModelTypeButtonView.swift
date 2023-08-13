//
//  ModelTypeButtonView.swift
//  Catalog
//
//  Created by Jung peter on 8/11/23.
//

import SwiftUI

struct ModelTypeButtonView: View {

  @Binding var isSelected: Bool

    var body: some View {
      VStack(alignment: .leading) {
        Text("\(Text("38%").foregroundColor(isSelected ? .activeBlue2 : .gray600))의 선택")
          .foregroundColor(.gray500)
          .catalogFont(type: .HeadKRMedium14)
        Text("디젤 2.2")
          .catalogFont(type: .HeadKRMedium16)
          .foregroundColor(isSelected ? .gray900 : .gray600)
        HStack {
          Text("+0 원")
            .foregroundColor(isSelected ? .gray900 : .gray600)
            .catalogFont(type: .TextKRMedium16)
          Spacer()
          Image("check").renderingMode(.template).foregroundColor(isSelected ? .activeBlue2 : .gray200)
        }
      }
      .padding(EdgeInsets(top: 8, leading: 13, bottom: 7, trailing: 8))
      .cornerRadius(4)
      .buttonSelected(isselected: $isSelected)
    }
}

struct ModelTypeButtonView_Previews: PreviewProvider {
    static var previews: some View {
      ModelTypeButtonView(isSelected: .constant(true))
    }
}

fileprivate extension View {

  @ViewBuilder
  func buttonSelected(isselected: Binding<Bool>) -> some View {
    if isselected.wrappedValue {
      modifier(ModelButtonSelectedBackground())
    } else {
      modifier(ModelButtonUnSelectedBackground())
    }

  }

}
