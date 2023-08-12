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
          if isPresented {
            DimmedZStack { }
              .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                  self.isModalPresented = true
                }
              }
          }
        }
        .blurredFullScreenCover(.init(.clear), show: $isModalPresented, onDismiss: { }) {
          ModelPopUp()
            .padding(EdgeInsets(top: 135, leading: 27, bottom: 135, trailing: 27))
        }
        .task {
          DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isPresented = true
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
