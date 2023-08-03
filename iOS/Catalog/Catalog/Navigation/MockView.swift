//
//  MockView.swift
//  Catalog
//
//  Created by Jung peter on 8/3/23.
//

import SwiftUI

struct MockView: View {
  var color: Color
  var body: some View {
    color
      .edgesIgnoringSafeArea(.all)
  }
}


struct MockView_Previews: PreviewProvider {
    static var previews: some View {
      MockView(color: .activeBlue)
    }
}
