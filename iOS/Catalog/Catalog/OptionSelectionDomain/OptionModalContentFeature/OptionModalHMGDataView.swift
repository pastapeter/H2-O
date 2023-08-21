//
//  OptionModalHMGDataView.swift
//  Catalog
//
//  Created by Jung peter on 8/21/23.
//

import SwiftUI

struct OptionModalHMGDataView: View {
    var body: some View {
      HStack {
        makeSubContentView(title: "구매자의 절반 이상이\n선택했어요.", data: "2,384개", caption: "최근 90일 동안")
        Spacer().frame(width: CGFloat(27).scaledWidth)
        makeSubContentView(title: "주행 중 실제로\n이만큼 사용해요.", data: "73번", caption: "1.5만km 당")
      }
    }
}

extension OptionModalHMGDataView {
  @ViewBuilder
  func makeSubContentView(title: String, data: String, caption: String) -> some View {
    VStack(alignment: .leading, spacing: 0) {
      Text(title)
        .catalogFont(type: .TextKRMedium12)
        .frame(height: CGFloat(36).scaledHeight)
      Spacer().frame(height: CGFloat(4).scaledHeight)
      Divider()
      Spacer().frame(height: CGFloat(6).scaledHeight)
      Text(data)
        .catalogFont(type: .HeadKRRegular24)
      Text(caption)
        .catalogFont(type: .TextKRRegular10)
        .foregroundColor(.gray600)
    }
  }
}

struct OptionModalHMGDataView_Previews: PreviewProvider {
    static var previews: some View {
        OptionModalHMGDataView()
    }
}
