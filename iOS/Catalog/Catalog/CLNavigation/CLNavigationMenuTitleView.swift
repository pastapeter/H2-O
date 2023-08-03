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
        return Color.primary
      case .inactive:
        return Color.gray200
      }
    }
  }
  
  @Binding var currentPage: Int
  @Binding var status: Status
  let namespace: Namespace.ID
  var navigationMenuTitle: String
  var page: Int
  
  var body: some View {
    Button {
      currentPage = page
    } label: {
      VStack {
        Spacer()
        if currentPage == page {
          Text(navigationMenuTitle).catalogFont(type: .HeadKRMedium14).foregroundColor(Status.active.color)
          Color.black
            .frame(height: 2)
            .matchedGeometryEffect(id: "underline", in: namespace, properties: .frame)
        } else {
          Text(navigationMenuTitle).catalogFont(type: .HeadKRMedium14).foregroundColor(status.color)
          Color.clear.frame(height: 2)
        }
      }
      .animation(.spring(), value: self.currentPage)
    }
    .buttonStyle(.plain)

  }
}
