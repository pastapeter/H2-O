//
//  FilterButton.swift
//  Catalog
//
//  Created by Jung peter on 8/16/23.
//

import SwiftUI

struct FilterButtonStyle: ButtonStyle {

  var isSelected: Bool

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(EdgeInsets(top: 6, leading: 20, bottom: 6, trailing: 20))
      .foregroundColor(isSelected ? .primary0 : .gray600)
      .background(isSelected ? Color.skyBlueCardBG : .white)
      .cornerRadius(20)
      .overlay(
        RoundedRectangle(cornerRadius: 20)
          .inset(by: 0.5)
          .stroke(isSelected ? Color.skyBlue : Color.gray200)
      )
  }
}

struct FilterButtonStyle_Previews: PreviewProvider {
  static var previews: some View {
    Button(action: {}, label: {
      Text("전체")
    })
    .buttonStyle(FilterButtonStyle(isSelected: false))
  }
}
