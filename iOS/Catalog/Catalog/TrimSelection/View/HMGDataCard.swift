//
//  HMGDataCard.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/11.
//

import SwiftUI

struct HMGDataCard {
  var options: [HMGDatum]
  var attributedString: AttributedString {
    var text: AttributedString = "해당 트림에 포함된 옵션들의 실활용 데이터에요."
    guard let targetRange = text.range(of: "실활용 데이터") else { return "" }
    text.foregroundColor = Color.gray900
    text[targetRange].foregroundColor = Color.activeBlue
    return text
  }
}

extension HMGDataCard: View {
  var body: some View {
    ZStack(alignment: .leading) {
      
      VStack(alignment: .leading) {
        HMGTag()
        Spacer()
      }
      
      VStack(alignment: .leading , spacing: 16) {
        Text(attributedString)
          .catalogFont(type: .TextKRMedium12)
          .frame(width: CGFloat(252).scaledWidth, height: CGFloat(16).scaledWidth, alignment: .leading)
          .padding(.top, CGFloat(12).scaledHeight)
        
        if options.isEmpty {
          Spacer().frame(height: CGFloat(94).scaledHeight)
        } else {
          HStack(spacing: CGFloat(36).scaledWidth) {
            ForEach(0..<options.count) { idx in
              VStack(spacing: 4) {
                Text(options[idx].optionTitle)
                  .catalogFont(type: .TextKRRegular10)
                  .foregroundColor(Color.gray900)
                  .frame(height: CGFloat(36).scaledHeight, alignment: .topLeading)
                
                Divider().frame(width: CGFloat(60).scaledWidth)
                
                Text("\(options[idx].optionFrequency)회")
                  .catalogFont(type: .HeadKRRegular24)
                  .foregroundColor(Color.gray900)
                Text("15,000km 당")
                  .catalogFont(type: .TextKRRegular10)
                  .foregroundColor(Color.gray600)
              }
              .frame(width: CGFloat(60).scaledWidth, height: CGFloat(94).scaledHeight)
            }
          }
        }
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.gray50)
  }
}

struct HMGDataCard_Previews: PreviewProvider {
  static var previews: some View {
    HMGDataCard(options: [HMGDatum(optionTitle: "안전 하차 보조", optionFrequency: 42),
                          HMGDatum(optionTitle: "후측방 충돌\n경고", optionFrequency: 42),
                          HMGDatum(optionTitle: "후방 교차\n충돌방지 보조", optionFrequency: 42)])
  }
}


