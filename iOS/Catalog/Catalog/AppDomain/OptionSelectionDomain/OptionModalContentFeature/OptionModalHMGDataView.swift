//
//  OptionModalHMGDataView.swift
//  Catalog
//
//  Created by Jung peter on 8/21/23.
//

import SwiftUI

struct OptionModalHMGDataView: View {
  
  var state: DetailOptionInfo.HMGData
  
    var body: some View {
      HStack {
        if let overhalf = state.isOverHalf, let choiceCount = state.choiceCount {
          makeSubContentView(title: "구매자의 \(overhalf ? "절반 이상이" : "절반 이하가")\n선택했어요.", data: "\(choiceCount.description)개", caption: "최근 90일 동안")
        } else {
          Rectangle().fill(.clear)
        }
        Spacer().frame(width: CGFloat(27).scaledWidth)
        if let usecount = state.useCount {
          makeSubContentView(title: "주행 중 실제로\n이만큼 사용해요.", data: "\(usecount.description)번", caption: "1.5만km 당")
        } else {
          Rectangle().fill(.clear)
        }
      }
      .padding(.bottom, 14)
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
