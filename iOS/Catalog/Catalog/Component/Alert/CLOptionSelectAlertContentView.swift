//
//  CLOptionSelectAlertContentView.swift
//  Catalog
//
//  Created by Jung peter on 8/7/23.
//

import SwiftUI

struct CLOptionSelectAlertContentView: AlertContentable {

  var info: String?

    var body: some View {
      VStack {
        Spacer().frame(height: 57)
        Text("\(Text(info ?? "").foregroundColor(Color.primary500))의 옵션이\n내 견적서에 추가되었습니다.")
          .catalogFont(type: .TextKRMedium14)
          .frame(height: 51, alignment: .top)
          .multilineTextAlignment(.center)
          .padding(.horizontal, 30)
        Spacer().frame(height: 40)
      }
    }
}

struct CLOptionSelectAlertContentView_Previews: PreviewProvider {
    static var previews: some View {
      CLOptionSelectAlertContentView( info: "2열 통풍시트")
    }
}
