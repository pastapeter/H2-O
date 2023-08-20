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
  var horizontalSpacing: CGFloat = CGFloat(11).scaledWidth
  var verticalSpacing: CGFloat = CGFloat(6).scaledHeight
  var showNavigationDivider: Bool = false

  var body: some View {
    VStack(spacing: 0) {
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
     .background(Color.white)
      if showNavigationDivider {
        Divider().frame(height: 2).foregroundColor(Color.gray200).offset(y: -2)
      }
    }

  }
}
