//
//  ModelTypeSelectionContainerView.swift
//  Catalog
//
//  Created by Jung peter on 8/11/23.
//

import SwiftUI

struct ModelTypeSelectionContainerView: View {

  @State var isPresented = false
  @State var isModalPresented = false
  @State var uuid = UUID()
  @Namespace private var animation

    var body: some View {
      ScrollView {
        ZStack {
          LazyVStack(alignment: .leading) {
            Text("모델타입을 선택해주세요")
              .catalogFont(type: .HeadKRMedium18)
            ModelTypeView()
            ModelTypeView()
            ModelTypeView()
            ModelTypeView()
          }
          .padding(.horizontal, 16)
        }
        .CLDialogFullScreenCover(show: $isModalPresented) {

          ModalPopUpComponent(uuid: $uuid, submitAction: { }, animationID: animation) {
            ModelContentView(state: .mock())
          }
          .cornerRadius(4)
        }
//        .blurredFullScreenCover(.init(.clear), show: $isModalPresented, onDismiss: { }) {
//          Rectangle()
//              ModalPopUpComponent(uuid: $uuid, submitAction: { }, animationID: animation) {
//                ModelContentView(state: .mock())
//              }
//              .cornerRadius(4)
//        }
        .task {
          DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isModalPresented = true
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
