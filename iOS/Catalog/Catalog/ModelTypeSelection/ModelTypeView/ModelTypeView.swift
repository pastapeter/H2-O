//
//  ModelTypeView.swift
//  Catalog
//
//  Created by Jung peter on 8/11/23.
//

import SwiftUI

struct ModelTypeView: View {

  var title: String = "파워트레인"

    var body: some View {
      VStack(alignment: .leading) {
        Text(title)
          .catalogFont(type: .HeadKRMedium18)
        Spacer().frame(height: 8)
        ZStack(alignment: .topTrailing) {
          makeDetailButton()
          VStack {
            Spacer().frame(height: 12)
            Image("powertrain")
            Spacer().frame(height: 8)
            ModelTypeButtonContainer()
            .padding(.horizontal, 4)
            .padding(.bottom, 4)
          }
        }
        .background(Color.gray50)
        .cornerRadius(8)
      }
    }

  @ViewBuilder
  func makeDetailButton() -> some View {
    ZStack {
      Button {
        print("ButtonClick")
      } label: {
        Text("HMG Data")
          .catalogFont(type: .HeadENBold10)
      }
      .buttonStyle(HMGButtonArrowStyle())
    }
  }
}

struct ModelTypeView_Previews: PreviewProvider {
    static var previews: some View {
        ModelTypeView()
    }
}
