//
//  NavigationMenuTitle.swift
//  Catalog
//
//  Created by Jung peter on 8/3/23.
//

import SwiftUI

struct CLNavigationMenuTitleView: View {

  enum Status {
    case completed
    case active
    case inactive

    var color: Color {
      switch self {
        case .completed:
          return Color.primary200
        case .active:
          return Color.primary0
        case .inactive:
          return Color.gray200
      }
    }
  }

  @Binding var currentPage: Int
  var status: Status?
  let namespace: Namespace.ID
  var navigationMenuTitle: String
  var page: Int
  var font: CatalogTextType
  var spacing: CGFloat = 6

  var body: some View {
    Button {
      currentPage = page
    } label: {
      VStack(spacing: spacing) {
        Spacer()
        if currentPage == page {
          Text(navigationMenuTitle)
            .catalogFont(type: font)
            .foregroundColor(Status.active.color)
          Color.black
            .frame(width: 18, height: 2)
            .cornerRadius(1)
            .matchedGeometryEffect(id: "underline", in: namespace, properties: .frame)
        } else {
          Text(navigationMenuTitle)
            .catalogFont(type: font)
            .foregroundColor(status?.color ?? Status.inactive.color)
          Color.clear.frame(height: 2)
        }
      }
      .fixedSize()
      .animation(.spring(), value: self.currentPage)
    }
    .buttonStyle(.plain)

  }
}
