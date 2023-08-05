//
//  CLAlert.swift
//  Catalog
//
//  Created by Jung peter on 8/5/23.
//

import SwiftUI

struct CLAlertView: View {

  var message: String?
  var cancelAction: () -> Void
  var submitAction: () -> Void

    var body: some View {
      VStack(alignment: .center) {
        Spacer().frame(height: 57)
        Text(message ?? "")
          .catalogFont(type: .TextKRMedium14)
          .frame(height: 51, alignment: .top)
          .multilineTextAlignment(.center)
          .padding(.horizontal, 30)
        Spacer().frame(height: 40)
        CLDualChoiceButton(leftText: "취소", rightText: "종료", height: 52, leftAction: cancelAction, rightAction: submitAction)
      }
      .background(.white)
      .cornerRadius(5)
    }
}

extension CLAlertView {
  @ViewBuilder
  static func build(message: String?, cancelAction: @escaping ()->Void, submitAction: @escaping () -> Void) -> some View {
    CLAlertView(message: "", cancelAction: cancelAction, submitAction: submitAction)
  }
}

struct CLAlertView_Previews: PreviewProvider {
    static var previews: some View {
      CLAlertView(message: "내 차 만들기를 종료하시겠습니까?\n지금 서비스 종료 시 저장되지 않습니다.", cancelAction: { }, submitAction: { })
    }
}


