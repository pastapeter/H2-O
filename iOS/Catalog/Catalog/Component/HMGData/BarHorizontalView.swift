//
//  BarHorizontalView.swift
//  Catalog
//
//  Created by Jung peter on 8/12/23.
//

import SwiftUI

struct BarHorizontalView: View {

  var percent: Double

  var body: some View {
    ZStack(alignment: .leading) {
      Rectangle().foregroundColor(.gray200)
      GeometryReader { geometry in
        Rectangle()
          .path(in: CGRect(x: 0, y: 0, width: (percent) * geometry.size.width, height: geometry.size.height))
          .fill(Color.activeBlue2)
      }
    }
    .frame(height: 4)
  }
}

struct BarHorizontalView_Previews: PreviewProvider {
  static var previews: some View {
    BarHorizontalView(percent: (202 / 3800))
  }
}
