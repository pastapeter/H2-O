//
//  NavigationView.swift
//  Catalog
//
//  Created by Jung peter on 8/2/23.
//

import SwiftUI

struct NavigationView: IntentBindingType {
  @StateObject var container: Container<NavigationIndentType, NavigationModel.State>
  var intent: NavigationIndentType { container.intent }
  var state: NavigationModel.State { intent.state }
  let colors: [Color] = [.purple, .pink, .orange, .yellow, .activeBlue, .activeBlue2, .sand]
}

extension NavigationView {
  var currentPageBinding: Binding<Int> {
    .init(get: { state.currentPage }, set: {  intent.send(action: .onTapNavTab(index: $0))})
  }
}

extension NavigationView: View {

  var body: some View {
    VStack {
    NavLogo()
      NavigationMenuView(currentPage: currentPageBinding)
      TabView(selection: currentPageBinding) {
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

extension NavigationView {
  @ViewBuilder
  static func build(intent: NavigationIndent) -> some View {
    NavigationView(container: .init(
      intent: intent as NavigationIndent,
      state: intent.state,
      modelChangePublisher: intent.objectWillChange))
  }
}
