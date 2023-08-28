//
//  AverageBanner.swift
//  Catalog
//
//  Created by Jung peter on 8/13/23.
//

import SwiftUI

struct FuelEfficiencyAverageBannerView: IntentBindingType {

  @StateObject var container: Container<FuelEfficiencyAverageBannerIntentType, FuelEfficiencyAverageBannerModel.ViewState, FuelEfficiencyAverageBannerModel.State>
  
  var intent: FuelEfficiencyAverageBannerIntentType {
    container.intent
  }
  
  var viewState: FuelEfficiencyAverageBannerModel.ViewState {
    intent.viewState
  }
  
  var state: FuelEfficiencyAverageBannerModel.State {
    intent.state
  }

}

extension FuelEfficiencyAverageBannerView: View {

    var body: some View {
      VStack(alignment: .leading) {
        Text("\(Text(viewState.engine).foregroundColor(.activeBlue2))와 \(Text(viewState.wheelType).foregroundColor(.activeBlue2))의 배기량과 평균연비입니다.")
        HStack(alignment: .center) {
          verticalBanner(title: "배기량", dataStr: "\(viewState.displacement)cc")
          Spacer()
          Divider()
          Spacer()
          verticalBanner(title: "평균연비", dataStr: "\(viewState.fuelEfficiency)km/L")
        }
        .padding(.horizontal, 56)
        .padding(.top, 16)
        .padding(.bottom, 20)
      }
      .onAppear { intent.send(action: .calculateFuelEfficiency)}
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

extension FuelEfficiencyAverageBannerView {
  static func build(intent: FuelEfficiencyAverageBannerIntent) -> some View {
    
    FuelEfficiencyAverageBannerView(container: .init(intent: intent, viewState: intent.viewState, state: intent.state, modelChangePublisher: intent.objectWillChange))
    
  }
}

