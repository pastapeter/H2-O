//
//  NavigationMenuTitle.swift
//  Catalog
//
//  Created by Jung peter on 8/3/23.
//

import SwiftUI

struct NavigationMenuTitleView: View {
  @Binding var currentPage: Int
  let namespace: Namespace.ID
  var navigationMenuTitle: String
  var page: Int
  var body: some View {
    Button {
      currentPage = page
    } label: {
      VStack {
        Spacer()
        Text(navigationMenuTitle).catalogFont(type: .HeadKRMedium14)
        if currentPage == page {
          Color.black
            .frame(height: 2)
            .matchedGeometryEffect(id: "underline", in: namespace, properties: .frame)
        } else {
          Color.clear.frame(height: 2)
        }
      }
      .animation(.spring(), value: self.currentPage)
    }
    .buttonStyle(.plain)

  }
}
