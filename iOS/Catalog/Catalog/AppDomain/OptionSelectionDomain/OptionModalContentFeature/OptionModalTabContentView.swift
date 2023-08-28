//
//  OptionModalTabContentView.swift
//  Catalog
//
//  Created by Jung peter on 8/21/23.
//

import SwiftUI

struct OptionModalTabContentView: View {
  
  @State var currentPage: Int = 0
  var state: PackageInfo
  
    var body: some View {
      VStack(alignment: .leading) {
        NavigationMenuView(currentPage: $currentPage,
                             navigationMenuTitles: state.components.map { $0.name },
                             titleFont: .TextKRMedium14,
                             verticalSpacing:0,
                             barType: .dynamic,
                             scrollable: true)
          .frame(maxWidth: .infinity)
          .padding(.leading, CGFloat(30).scaledWidth)
        
        TabView(selection: $currentPage) {
          if state.components.count > 0 {
            ForEach(state.components.indices) { i in
              OptionModalContentView(state: DetailOptionInfo(
                id: .init(), category: state.components[i].category,
                containsChoiceCount: state.choiceCount != nil,
                containsUseCount: state.components[i].useCount != nil,
                description: state.components[i].description,
                hashTags: state.components[i].hashTags,
                hmgData: .init(isOverHalf: state.isOverHalf,
                               choiceCount: state.choiceCount,
                               useCount: state.components[i].useCount),
                image: state.components[i].image,
                title: state.components[i].name,
                price: state.price))
            }
          }
        }
        .onAppear {
          UIScrollView.appearance().isScrollEnabled = true
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
      }
    }
}

struct OptionModalTabContentView_Previews: PreviewProvider {
    static var previews: some View {
      OptionModalTabContentView( state: .mock())
    }
}
