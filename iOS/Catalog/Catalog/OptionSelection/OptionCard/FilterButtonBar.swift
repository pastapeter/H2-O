//
//  FilterButtonBar.swift
//  Catalog
//
//  Created by Jung peter on 8/16/23.
//

import SwiftUI

struct FilterButtonBar: View {
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        ForEach(OptionFilter.DefaultOptionFilter.allCases.indices, id: \.self) { i in
          FilterButtonView(title: OptionFilter.DefaultOptionFilter.allCases[i].description,
                           isSelected: false) { }
        }
      }
    }
  }
}

struct FilterButtonBar_Previews: PreviewProvider {
  static var previews: some View {
    FilterButtonBar()
  }
}
