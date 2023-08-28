//
//  TrimCardView.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/11.
//

import SwiftUI

struct TrimCardView: View {
  
  var trim: Trim
  
  var body: some View {
    VStack(spacing: 0) {
      
      HStack {
        VStack(alignment: .leading) {
          Text(trim.description)
            .catalogFont(type: .TextKRRegular14)
            .foregroundColor(Color.gray900)
          Text(trim.name)
            .catalogFont(type: .HeadKRBold26)
            .foregroundColor(Color.primary0)
          Text(trim.price.wonWithSpacing)
            .catalogFont(type: .HeadKRMedium18)
            .foregroundColor(Color.primary)
        }
        .padding(.top, CGFloat(20).scaledHeight)
        .padding(.leading, CGFloat(24).scaledHeight)
        Spacer()
      }
      .frame(height: CGFloat(130).scaledHeight)
      
      GeometryReader { proxy in
        AsyncCachedImage(url: trim.externalImage, content: { image in
          image
            .resizable()
            .scaledToFit()
            .frame(width: CGFloat(343).scaledWidth)
        })
        .offset(x: proxy.size.width / 4)
      }
      .frame(height: CGFloat(160).scaledHeight)
      .clipped()
      
      
      HMGDataCard(options: trim.hmgData)
        .frame(height: CGFloat(188).scaledHeight)
    }
  }
}

struct TrimCardView_Previews: PreviewProvider {
  static var previews: some View {
    TrimCardView(trim: Trim(id: 1234,
                            name: "Le Blanc",
                            description: "실용적인 사양의 경제적인 펠리세이드",
                            price: CLNumber(40440000),
                            hmgData: [HMGDatum(optionTitle: "안전 하차 보조", optionFrequency: 42), HMGDatum(optionTitle: "후측방 충돌\n경고", optionFrequency: 42),
                                      HMGDatum(optionTitle: "후방 교차\n충돌방지 보조", optionFrequency: 42)]))
  }
}
