//
//  ModalPopUpComponent.swift
//  Catalog
//
//  Created by Jung peter on 8/11/23.
//

import SwiftUI

struct ModalPopUpComponent<ModalPopUpContent: View>: View {

  @Binding var uuid: UUID
  var submitAction: () -> Void
  var animationID: Namespace.ID

  @Environment(\.dismiss) private var dismiss
  @State private var animateView: Bool = false
  @State private var animateContent: Bool = false
  @ViewBuilder var content: () -> ModalPopUpContent

    var body: some View {
      VStack {
        if animateView {
          VStack {
              titleView("파워트레인")
                .padding(.horizontal, 16)
              content()
              CLButton(subText: "+280,000원", mainText: "선택하기", height: 87, backgroundColor: .activeBlue, buttonAction: submitAction)
                .frame(height: 56)
          }
          .matchedGeometryEffect(id: uuid.uuidString, in: animationID)
          .frame(width: 200, height: 200)
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(content: {
        Color.white
          .ignoresSafeArea()
          .opacity(animateContent ? 1 : 0)
      })
      .onAppear {
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.8)) {
          animateView = true
          animateContent = true
        }
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
      @Namespace var animation
      ModalPopUpComponent(uuid: .constant(UUID()), submitAction: { }, animationID: animation) {
        ModelContentView(state: .mock())
      }
    }
}
