//
//  NavLogo.swift
//  Catalog
//
//  Created by Jung peter on 8/3/23.
//

import SwiftUI

struct NavLogo: View {
  var body: some View {
    ZStack(alignment: .center) {
      HStack(alignment: .center) {
        Button(action: {}) {
          Text("펠리세이드")
          Image("arrow_down_small")
        }
        Spacer()
        Button("종료", action: {})
      }.padding(.horizontal, 20)
      Button(action: {}) {
        Image("logo")
      }
    }
  }
}

struct NavLogo_Previews: PreviewProvider {
    static var previews: some View {
        NavLogo()
    }
}
