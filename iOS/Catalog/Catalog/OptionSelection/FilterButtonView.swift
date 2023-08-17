//
//  FilterButtonView.swift
//  Catalog
//
//  Created by Jung peter on 8/16/23.
//

import SwiftUI

struct FilterButtonView: View {

  var title: String
  var isSelected: Bool
  var action: () -> Void

    var body: some View {
      Button(action: action) {
        Text(title)
          .catalogFont(type: .TextKRMedium14)
      }
      .buttonStyle(FilterButtonStyle(isSelected: isSelected))
    }
}

struct FilterButtonView_Previews: PreviewProvider {
    static var previews: some View {
      FilterButtonView(title: "전체", isSelected: true, action: { })
    }
}
