//
//  FilterButtonBar.swift
//  Catalog
//
//  Created by Jung peter on 8/16/23.
//

import SwiftUI

struct FilterState {
  var filters = OptionFilter.additionalOptionFilter
  var selectedFilterId: Int = 0
}

struct FilterButtonBar: View {
  
  let state: FilterState
  let intent: OptionCardScrollIntentType

  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        ForEach(state.filters.indices, id: \.self) { i in
          FilterButtonView(title: state.filters[i].description,
                           isSelected: i == state.selectedFilterId) {
            intent.send(action: .onTapFilterButton(index: i))
          }
        }
      }
    }
  }
}
