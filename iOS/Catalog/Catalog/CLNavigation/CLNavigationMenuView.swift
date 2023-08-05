//
//  NavigationMenuView.swift
//  Catalog
//
//  Created by Jung peter on 8/3/23.
//

import SwiftUI

struct CLNavigationMenuView: View {
  
  @Binding var currentPage: Int
  @Binding var menuStatus: [CLNavigationMenuTitleView.Status]
  @Namespace var namespace
  var navigationMenuTitles = ["트림", "타입", "외장", "내장", "옵션", "완료"]
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 11) {
        ForEach(Array(zip(self.navigationMenuTitles.indices,
                          self.navigationMenuTitles)), id: \.0) { index, name in
          CLNavigationMenuTitleView(currentPage: self.$currentPage,
                                    status: $menuStatus[index], namespace: namespace.self,
                                    navigationMenuTitle: name,
                                    page: index)
            .frame(width: 52)
        }
      }
      .padding(.horizontal, 20)
    }
    .background(Color.white)
    .frame(height: 30)
  }
}
