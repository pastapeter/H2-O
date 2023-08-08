//
//  CLSingleLineAlertContentView.swift
//  Catalog
//
//  Created by Jung peter on 8/7/23.
//

import SwiftUI

struct CLSingleLineAlertContentView: AlertContentable {

  var info: String?

    var body: some View {
      VStack {
        Spacer().frame(height: 65)
        Text(info ?? "")
          .catalogFont(type: .TextKRMedium14)
          .frame(height: 51, alignment: .top)
          .multilineTextAlignment(.center)
          .padding(.horizontal, 30)
        Spacer().frame(height: 32)
      }
    }
}

struct CLSingleLineAlertContentView_Previews: PreviewProvider {
    static var previews: some View {
        CLSingleLineAlertContentView()
    }
}
