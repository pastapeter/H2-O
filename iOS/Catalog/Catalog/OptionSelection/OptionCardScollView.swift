//
//  OptionCardScollView.swift
//  Catalog
//
//  Created by Jung peter on 8/16/23.
//

import SwiftUI

struct OptionCardScollView: View {
  var body: some View {
    VStack {
      FilterButtonBar()
      ScrollView {
        VStack(spacing: 16) {
          OptionCardView(isSelected: true)
          OptionCardView()
          OptionCardView()
          OptionCardView()
          OptionCardView()
          OptionCardView()
          OptionCardView()
          OptionCardView()
          OptionCardView()
        }
        .padding(.horizontal, 16)
      }
    }
    
  }
}

struct OptionCardScollView_Previews: PreviewProvider {
  static var previews: some View {
    OptionCardScollView()
  }
}
