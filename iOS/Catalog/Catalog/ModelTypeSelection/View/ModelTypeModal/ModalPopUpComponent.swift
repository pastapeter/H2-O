//
//  ModalPopUpComponent.swift
//  Catalog
//
//  Created by Jung peter on 8/11/23.
//

import SwiftUI

struct ModalPopUpComponent<ModalPopUpContent: View>: View {

  var state: ModelTypeContent

  var submitAction: () -> Void

  @Environment(\.dismiss) private var dismiss

  @State private var animateView: Bool = false

  @State private var animateContent: Bool = false

  @ViewBuilder var content: () -> ModalPopUpContent

}

extension ModalPopUpComponent {

  var body: some View {
    VStack {
      if animateView {
        VStack {
          titleView(state.title)
            .padding(.horizontal, 16)
          content()
          CLButton(mainText: "선택하기", subText: state.price.signedWon,
                   height: 87,
                   backgroundColor: .activeBlue,
                   buttonAction: submitAction)
            .frame(height: 56)
        }
        .background(.white)
        .cornerRadius(4)
        .frame(height: UIScreen.main.bounds.height * 0.67)
        .padding(.horizontal, 30)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(content: {
      DimmedZStack { }
        .edgesIgnoringSafeArea(.all)
        .opacity(animateContent ? 0.8 : 0)
    })
    .onAppear {
      withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.8)) {
        animateView = true
        animateContent = true
      }
    }
  }

}

extension ModalPopUpComponent {
  @ViewBuilder
  func titleView(_ text: String) -> some View {
    ZStack(alignment: .center) {
      Text(text)
        .catalogFont(type: .HeadKRMedium18)
        .foregroundColor(.gray900)
      HStack {
        Spacer()
        Button {
          withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.8)) {
            dismiss()
            animateView = false
            animateContent = false
          }
        } label: {
          Image("cancel")
        }
      }
    }
    .padding(.top, 20)
    .padding(.bottom, 12)
  }
}

struct ModalPopUpComponent_Previews: PreviewProvider {
  static var previews: some View {
    ModalPopUpComponent(state: .mock(), submitAction: { }) {
      ModelContentView(state: .init(content: .mock(), hmgData: .mock()))
    }
  }
}
