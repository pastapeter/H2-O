//
//  NavLogo.swift
//  Catalog
//
//  Created by Jung peter on 8/3/23.
//

import SwiftUI

struct CLTopNaviBar: View {

  var intent: CLNavigationIntentType

  var body: some View {
    ZStack(alignment: .center) {
      HStack(alignment: .center) {
        Button {
          intent.send(action: .onTapSwitchVehicleModel)
        } label: {
          Text("펠리세이드")
            .catalogFont(type: .TextKRMedium14)
            .foregroundColor(.gray800)
          Image("arrow_down_small")
        }
        .buttonStyle(.plain)
        Spacer()
        Button {
          intent.send(action: .onTapFinish)
        } label: {
          Text("종료")
            .catalogFont(type: .TextKRMedium14)
            .foregroundColor(.gray800)
        }
        .buttonStyle(.plain)
      }.padding(.horizontal, 20)
      Button {
        intent.send(action: .onTapLogo)
      } label: {
        Image("logo")
      }
    }
    .padding(.bottom, 10)
  }
}
