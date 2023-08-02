//
//  NavigationView.swift
//  Catalog
//
//  Created by Jung peter on 8/2/23.
//

import SwiftUI

struct NavLogoBar: View {
  var body: some View {
    ZStack(alignment: .center) {
      HStack(alignment: .center) {
        Button(action: {}) {
          Text("펠리세이드")
          Image("arrow_down_small")
        }
        Spacer()
        Button("종료", action: {})
      }.padding(.horizontal, 20)
      Button(action: {}) {
        Image("logo")
      }
    }
  }
}

struct MockView: View {
  var color: Color
  var body: some View {
    color
      .edgesIgnoringSafeArea(.all)
  }
}

struct NavigationMenuTitle: View {
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

struct NavigationMenuView: View {
  @Binding var currentPage: Int
  @Namespace var namespace
  var navigationMenuTitles = ["트림", "타입", "외장", "내장", "옵션", "완료"]
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 11) {
        ForEach(Array(zip(self.navigationMenuTitles.indices, self.navigationMenuTitles)),id: \.0) { index, name in
          NavigationMenuTitle(currentPage: self.$currentPage, namespace: namespace.self, navigationMenuTitle: name, page: index)
            .frame(width: 52)
        }
      }
      .padding(.horizontal, 20)
    }
    .background(Color.white)
    .frame(height: 30)
  }
}

struct NavigationView: View {
  @State var currentPage: Int = 0
  let colors: [Color] = [.purple, .pink, .orange, .yellow, .activeBlue, .activeBlue2, .sand]
  var body: some View {
    VStack {
    NavLogoBar()
      NavigationMenuView(currentPage: self.$currentPage)
      TabView(selection: self.$currentPage) {
        MockView(color: colors[0]).tag(0)
        MockView(color: colors[1]).tag(1)
        MockView(color: colors[2]).tag(2)
        MockView(color: colors[3]).tag(3)
        MockView(color: colors[4]).tag(4)
        MockView(color: colors[5]).tag(5)
        MockView(color: colors[6]).tag(6)
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
