//
//  NavigationView.swift
//  Catalog
//
//  Created by Jung peter on 8/2/23.
//

import SwiftUI

struct NavigationView: View {
  @State var currentPage: Int = 0
  let colors: [Color] = [.purple, .pink, .orange, .yellow, .activeBlue, .activeBlue2, .sand]
  var body: some View {
    VStack {
    NavLogo()
      NavigationMenuView(currentPage: self.$currentPage)
      TabView(selection: self.$currentPage) {
        MockView(color: colors[0]).tag(0)
        MockView(color: colors[1]).tag(1)
        MockView(color: colors[2]).tag(2)
        MockView(color: colors[3]).tag(3)
        MockView(color: colors[4]).tag(4)
        MockView(color: colors[5]).tag(5)
      }
      .tabViewStyle(.page(indexDisplayMode: .never))
    }
  }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView()
    }
}
