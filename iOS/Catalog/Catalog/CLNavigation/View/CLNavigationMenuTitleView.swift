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
  
  enum BarType {
    case fixed
    case dynamic
  }

  @Binding var currentPage: Int
  var status: Status?
  let namespace: Namespace.ID
  var navigationMenuTitle: String
  var page: Int
  var font: CatalogTextType
  var spacing: CGFloat = 6
  var barWidthType: BarType = .fixed
  
  @State private var barWidth: CGFloat = 18
  @State private var textSize: CGSize = .zero

  var body: some View {
    Button {
      currentPage = page
    } label: {
      VStack(spacing: spacing) {
        Spacer()
        if currentPage == page {
          Text(navigationMenuTitle)
            .catalogFont(type: font)
            .background(ViewGeometry())
            .onPreferenceChange(ViewSizeKey.self) {
              if barWidthType == .dynamic {
                textSize = $0
                barWidth = textSize.width * 2/3
              }
            }
            .foregroundColor(Status.active.color)
          Color.black
            .frame(width: barWidth, height: 2)
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


struct ViewSizeKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct ViewGeometry: View {
    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: ViewSizeKey.self, value: geometry.size)
        }
    }
}
