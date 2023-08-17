//
//  NavigationMenuView.swift
//  Catalog
//
//  Created by Jung peter on 8/3/23.
//

import SwiftUI

struct CLNavigationMenuView: View {

  @Binding var currentPage: Int
  @Namespace var namespace
  var menuStatus: [CLNavigationMenuTitleView.Status]?
  var navigationMenuTitles: [String]
  var titleFont: CatalogTextType = .HeadKRMedium14
  var horizontalSpacing: CGFloat = 11
  var verticalSpacing: CGFloat = 6

  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: horizontalSpacing) {
        ForEach(Array(zip(self.navigationMenuTitles.indices,
                          self.navigationMenuTitles)), id: \.0) { index, name in
          CLNavigationMenuTitleView(currentPage: self.$currentPage,
                                    status: menuStatus?[index], namespace: namespace.self,
                                    navigationMenuTitle: name,
                                    page: index, font: titleFont, spacing: verticalSpacing)
            .frame(width: 52)
        }
      }
      .padding(.horizontal, 20)
    }
    .background(Color.white)
    .frame(height: 30)
  }
}
