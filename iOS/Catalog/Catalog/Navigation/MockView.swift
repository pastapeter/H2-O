//
//  MockView.swift
//  Catalog
//
//  Created by Jung peter on 8/3/23.
//

import SwiftUI

struct MockView: View {
  var image: String
  var body: some View {
    Image(image)
      .edgesIgnoringSafeArea(.all)
  }
}


struct MockView_Previews: PreviewProvider {
    static var previews: some View {
      MockView(image: "trim")
    }
}
