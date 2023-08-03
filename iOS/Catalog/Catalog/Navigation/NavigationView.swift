//
//  NavigationView.swift
//  Catalog
//
//  Created by Jung peter on 8/2/23.
//

import SwiftUI

struct NavigationView: IntentBindingType {
  @StateObject var container: Container<NavigationIndentType, CLNavigationModel.State>
  var intent: NavigationIndentType { container.intent }
  var state: CLNavigationModel.State { intent.state }
  let mockImageName: [String] = ["trim", "modelType", "external", "internal", "option", "complete"]
}

extension NavigationView {
  var currentPageBinding: Binding<Int> {
    .init(get: { state.currentPage }, set: {  intent.send(action: .onTapNavTab(index: $0))})
  }
}

extension NavigationView: View {

  var body: some View {
    VStack {
      NavLogo(intent: intent)
      NavigationMenuView(currentPage: currentPageBinding)
      TabView(selection: currentPageBinding) {
        MockView(image: mockImageName[0]).tag(0)
        MockView(image: mockImageName[1]).tag(1)
        MockView(image: mockImageName[2]).tag(2)
        MockView(image: mockImageName[3]).tag(3)
        MockView(image: mockImageName[4]).tag(4)
        MockView(image: mockImageName[5]).tag(5)
      }
      .tabViewStyle(.page(indexDisplayMode: .never))
    }
  }
}

extension NavigationView {
  @ViewBuilder
  static func build(intent: CLNavigationIndent) -> some View {
    NavigationView(container: .init(
      intent: intent as CLNavigationIndent,
      state: intent.state,
      modelChangePublisher: intent.objectWillChange))
  }
}
