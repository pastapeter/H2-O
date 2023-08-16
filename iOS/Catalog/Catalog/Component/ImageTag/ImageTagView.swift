//
//  ImageTagView.swift
//  Catalog
//
//  Created by Jung peter on 8/16/23.
//

import SwiftUI

struct ImageTagView: View {

  var title: String

  var body: some View {
    Text(title)
      .catalogFont(type: .TextKRRegular12)
      .foregroundColor(.gray50)
      .padding(.horizontal, 6)
      .padding(.vertical, 2)
      .background(Color.imageTagBackground)
      .cornerRadius(2)
  }
}

struct ImageTagView_Previews: PreviewProvider {
  static var previews: some View {
    ImageTagView(title: "캠핑")
  }
}
