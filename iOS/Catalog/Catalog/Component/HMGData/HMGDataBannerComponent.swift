//
//  HMGDataBannerComponent.swift
//  Catalog
//
//  Created by Jung peter on 8/13/23.
//

import SwiftUI

struct HMGDataBannerComponent<HMGDataBannerContent: View>: View {

  @ViewBuilder var content: () -> HMGDataBannerContent
  var hmgDataButtonAction: (() -> Void)?
}

extension HMGDataBannerComponent {

  var body: some View {
    VStack(alignment: .leading) {

      Button {
        hmgDataButtonAction?()
      } label: {
        Text("HMG Data")
          .catalogFont(type: .HeadENBold10)
      }
      .buttonStyle(HMGButtonStyle())
      content()
    }
    .padding(.horizontal, 20)
    .padding(.bottom, 25)
    .background(Color.gray50)
  }

}

struct HMGDataBannerComponent_Previews: PreviewProvider {
    static var previews: some View {
      HMGDataBannerComponent {

      }
    }
}
