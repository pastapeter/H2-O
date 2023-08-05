//
//  NavigationView.swift
//  Catalog
//
//  Created by Jung peter on 8/2/23.
//

import SwiftUI

struct CLNavigationView: IntentBindingType {
  @StateObject var container: Container<CLNavigationIndentType, CLNavigationModel.State>
  var intent: CLNavigationIndentType { container.intent }
  var state: CLNavigationModel.State { intent.state }
  let mockImageName: [String] = ["trim", "modelType", "external", "internal", "option", "complete"]
  @SwiftUI.State var menuStatus: [CLNavigationMenuTitleView.Status] = [.inactive, .inactive, .inactive, .inactive, .inactive, .inactive]
}

extension CLNavigationView {
  var currentPageBinding: Binding<Int> {
    .init(get: { state.currentPage }, set: {  intent.send(action: .onTapNavTab(index: $0))})
  }
}

extension CLNavigationView: View {

  var body: some View {
    VStack {
      CLTopNaviBar(intent: intent)
      CLNavigationMenuView(currentPage: currentPageBinding, menuStatus: $menuStatus)
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

extension CLNavigationView {
  @ViewBuilder
  static func build(intent: CLNavigationIndent) -> some View {
    CLNavigationView(container: .init(
      intent: intent as CLNavigationIndent,
      state: intent.state,
      modelChangePublisher: intent.objectWillChange))
  }
}

struct CLNavigationView_Previews: PreviewProvider {
  static var previews: some View {
    return CLNavigationView.build(intent: CLNavigationIndent(initialState: .init(currentPage: 0)))
  }
}
