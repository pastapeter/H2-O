//
//  NavLogo.swift
//  Catalog
//
//  Created by Jung peter on 8/3/23.
//

import SwiftUI

struct CLTopNaviBar: View {
  
  var intent: CLNavigationIndentType

  var body: some View {
    ZStack(alignment: .center) {
      HStack(alignment: .center) {
        Button(action: {
          intent.send(action: .onTapSwitchVehicleModel)
        }) {
          Text("펠리세이드").catalogFont(type: .TextKRMedium14).foregroundColor(.gray800)
          Image("arrow_down_small")
        }
        .buttonStyle(.plain)
        Spacer()
        Button(action: { intent.send(action: .onTapFinish)}) {
          Text("종료").catalogFont(type: .TextKRMedium14).foregroundColor(.gray800)
        }
        .buttonStyle(.plain)
      }.padding(.horizontal, 20)
      Button(action: {
        intent.send(action: .onTapLogo)
      }) {
        Image("logo")
      }
    }
  }
}

