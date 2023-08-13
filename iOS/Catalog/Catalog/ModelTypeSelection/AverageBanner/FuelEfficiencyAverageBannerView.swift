//
//  AverageBanner.swift
//  Catalog
//
//  Created by Jung peter on 8/13/23.
//

import SwiftUI

struct FuelEfficiencyAverageBannerView: View {
    var body: some View {
      VStack(alignment: .leading) {
        Text("\(Text("디젤2.2").foregroundColor(.activeBlue2))와 \(Text("2WD").foregroundColor(.activeBlue2))의 배기량과 평균연비입니다.")
        HStack(alignment: .center) {
          verticalBanner(title: "배기량", dataStr: "2,199cc")
          Spacer()
          Divider()
          Spacer()
          verticalBanner(title: "평균연비", dataStr: "12km/s")
        }
        .padding(.horizontal, 56)
        .padding(.top, 16)
        .padding(.bottom, 30)
      }
      .padding(.top, 12)
      .frame(maxWidth: .infinity)
    }

  @ViewBuilder
  private func verticalBanner(title: String, dataStr: String) -> some View {
    VStack(alignment: .center) {
      Text(title)
        .catalogFont(type: .TextKRRegular14)
        .foregroundColor(.gray900)
      Spacer().frame(height: 4)
      Text(dataStr)
        .catalogFont(type: .HeadENRegular28)
        .foregroundColor(.gray900)
    }
  }

}

struct FuelEfficiencyAverageBannerView_Previews: PreviewProvider {
    static var previews: some View {
      FuelEfficiencyAverageBannerView()
    }
}
