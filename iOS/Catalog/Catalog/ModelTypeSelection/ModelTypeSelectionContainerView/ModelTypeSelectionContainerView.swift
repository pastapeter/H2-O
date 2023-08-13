//
//  ModelTypeSelectionContainerView.swift
//  Catalog
//
//  Created by Jung peter on 8/11/23.
//

import SwiftUI

struct ModelTypeSelectionContainerView: View {

  @State var fuelState: FuelEfficiencyAverageBannerState = .mock()

    var body: some View {
      ScrollView {
        ZStack {
          LazyVStack(alignment: .leading) {
            Text("모델타입을 선택해주세요")
              .catalogFont(type: .HeadKRMedium18)
              .padding(.horizontal, 16)
            ModelTypeView()
            ModelTypeView()
            ModelTypeView()
            ModelTypeView()
            Spacer().frame(height: 38)
            HMGDataBannerComponent {
              FuelEfficiencyAverageBannerView(state: fuelState)
            }
          }
        }
      }
      .frame(maxWidth: .infinity)
    }
}

struct ModelTypeSelectionContainerView_Previews: PreviewProvider {
  static var previews: some View {
    ModelTypeSelectionContainerView()
  }
}
