//
//  CLQuitAlertContentVIew.swift
//  Catalog
//
//  Created by Jung peter on 8/7/23.
//

import SwiftUI

struct CLQuitAlertContentView: AlertContentable {
  var info: String?
  var body: some View {
    VStack {
      Spacer().frame(height: 57)
      Text(self.info ?? "내 차 만들기를 종료하시겠습니까?\n지금 서비스 종료 시 저장되지 않습니다.")
        .catalogFont(type: .TextKRMedium14)
        .frame(height: 51, alignment: .top)
        .multilineTextAlignment(.center)
        .padding(.horizontal, 30)
      Spacer().frame(height: 40)
    }
  }
}

struct CLQuitAlertContentView_Previews: PreviewProvider {
  static var previews: some View {
    CLQuitAlertContentView()
  }
}
