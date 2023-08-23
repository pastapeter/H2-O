//
//  CLOptionQuitAlertContentView.swift
//  Catalog
//
//  Created by Jung peter on 8/7/23.
//

import SwiftUI

struct CLOptionQuitAlertContentView: AlertContentable {

  var info: String?

    var body: some View {
      VStack {
        Spacer().frame(height: 30)
        Text("선택된 옵션 \(info ?? "")개")
          .catalogFont(type: .TextKRMedium14)
          .foregroundColor(.primary500)
        Spacer().frame(height: 16)
        Text("선택된 옵션이 있습니다.\n지금 서비스 종료 시 저장되지 않습니다.")
          .catalogFont(type: .TextKRMedium14)
          .frame(height: 51, alignment: .top)
          .multilineTextAlignment(.center)
          .padding(.horizontal, 30)
        Spacer().frame(height: 30)
      }
    }
}

struct CLOptionQuitAlertContentView_Previews: PreviewProvider {
    static var previews: some View {
        CLOptionQuitAlertContentView()
    }
}
