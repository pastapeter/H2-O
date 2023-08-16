//
//  OptionSelectionView.swift
//  Catalog
//
//  Created by Jung peter on 8/16/23.
//

import SwiftUI

enum OptionSelectionModel {
  
  struct State: Equatable {
    var currentPage: Int
//    var OptionStates: [OptionState]
  }
  
  enum ViewAction {
    
  }
  
}



struct OptionSelectionView: View {
  
  @State var currentPage: Int = 0
  
    var body: some View {
      VStack {
        CLTopNaviBar(intent: <#T##CLNavigationIntentType#>)
        CLNavigationMenuView(currentPage: <#T##Binding<Int>#>, menuStatus: <#T##Binding<[CLNavigationMenuTitleView.Status]>#>)
        TabView(selection: $currentPage) {
          OptionCardScollView()
          OptionCardScollView()
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
      }
      
    }
}

struct OptionSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        OptionSelectionView()
    }
}
