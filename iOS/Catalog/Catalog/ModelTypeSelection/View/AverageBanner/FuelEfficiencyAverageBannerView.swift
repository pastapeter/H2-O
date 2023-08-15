//
//  AverageBanner.swift
//  Catalog
//
//  Created by Jung peter on 8/13/23.
//

import SwiftUI

struct FuelEfficiencyAverageBannerState: Equatable {

  static func mock() -> Self {
    .init(engine: "디젤2.2", wheelType: "2WD", displacement: CLNumber(2199), fuelEfficiency: CLNumber(12))
  }

  var engine: String
  var wheelType: String
  var displacement: CLNumber
  var fuelEfficiency: CLNumber

}

struct FuelEfficiencyAverageBannerView: View {

  var state: FuelEfficiencyAverageBannerState

}

extension FuelEfficiencyAverageBannerView {

    var body: some View {
      VStack(alignment: .leading) {
        Text("\(Text(state.engine).foregroundColor(.activeBlue2))와 \(Text(state.wheelType).foregroundColor(.activeBlue2))의 배기량과 평균연비입니다.")
        HStack(alignment: .center) {
          verticalBanner(title: "배기량", dataStr: "\(state.displacement)cc")
          Spacer()
          Divider()
          Spacer()
          verticalBanner(title: "평균연비", dataStr: "\(state.fuelEfficiency)km/L")
        }
        .padding(.horizontal, 56)
        .padding(.top, 16)
        .padding(.bottom, 20)
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
      FuelEfficiencyAverageBannerView(state: .mock())
    }
}
