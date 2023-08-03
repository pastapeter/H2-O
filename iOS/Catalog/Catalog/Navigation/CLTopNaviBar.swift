//
//  NavLogo.swift
//  Catalog
//
//  Created by Jung peter on 8/3/23.
//

import SwiftUI

struct CLTopNaviBar: View {
  
  var intent: NavigationIndentType

  var body: some View {
    ZStack(alignment: .center) {
      HStack(alignment: .center) {
        Button(action: {
          intent.send(action: .onTapSwitchVehicleModel)
        }) {
          Text("펠리세이드")
          Image("arrow_down_small")
        }
        Spacer()
        Button("종료", action: {
          intent.send(action: .onTapFinish)
        })
      }.padding(.horizontal, 20)
      Button(action: {
        intent.send(action: .onTapLogo)
      }) {
        Image("logo")
      }
    }
  }
}

