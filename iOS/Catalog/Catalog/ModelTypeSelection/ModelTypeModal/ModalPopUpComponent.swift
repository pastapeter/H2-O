//
//  ModalPopUpComponent.swift
//  Catalog
//
//  Created by Jung peter on 8/11/23.
//

import SwiftUI

struct ModalPopUpComponent<ModalPopUpContent: View>: View {

  var submitAction: () -> Void
  @ViewBuilder var content: () -> ModalPopUpContent

    var body: some View {
      VStack(spacing: 0) {
        titleView("파워트레인")
          .padding(.horizontal, 16)
        content()

        CLButton(subText: "+280,000원", mainText: "선택하기", height: 87, backgroundColor: .activeBlue, buttonAction: submitAction)
      }
    }

  @ViewBuilder
  func titleView(_ text: String) -> some View {
    ZStack(alignment: .center) {
      Text(text)
        .catalogFont(type: .HeadKRMedium18)
        .foregroundColor(.gray900)
      HStack {
        Spacer()
        Image("cancel")
      }
    }
    .padding(.top, 20)
    .padding(.bottom, 12)
  }
}

struct ModalPopUpComponent_Previews: PreviewProvider {
    static var previews: some View {
      ModalPopUpComponent(submitAction: { }) {
        ModelContentView(state: .mock())
      }
    }
}
