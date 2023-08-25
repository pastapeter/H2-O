//
//  ExternalImageView.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/24.
//

import SwiftUI
struct ExteriorImageView {
  var intent: ExteriorSelectionIntentType
  var state: ExteriorSelectionModel.State
  @SwiftUI.State var currentIndex: Int = 0
  @SwiftUI.State var beforeIndex: Int = 0
}

extension ExteriorImageView: View {
  var body: some View {
    GeometryReader { proxy in
      VStack {
        Spacer()
        if state.colors.isEmpty {
          EmptyView()
        } else {
          AsyncImage(url: state.colors[state.currentSelectedIndex].color.exteriorImages[currentIndex]) { image in
            image
              .resizable()
              .frame(height: CGFloat(198).scaledHeight, alignment: .bottom)
          } placeholder: {
            VStack {
              if !state.images[0].isEmpty {
                Image(data: state.images[state.currentSelectedIndex][beforeIndex])?
                  .resizable()
              } else {
                ProgressView()
              }
            }

            .frame(height: CGFloat(198).scaledHeight, alignment: .bottom)
          }

          .gesture(
            DragGesture()
              .onChanged { drag in
                print(state.currentSelectedIndex)
                let count = state.colors[state.currentSelectedIndex].color.exteriorImages.count
                // 왼쪽으로 스크롤
                if drag.translation.width < 0 {
                  beforeIndex = currentIndex
                  currentIndex += 1
                  if currentIndex > count - 1 {
                    currentIndex = 0
                  }
                }
                // 오른쪽으로 스크롤
                else {
                  beforeIndex = currentIndex
                  currentIndex -= 1
                  if currentIndex < 0 {
                    currentIndex = count - 1
                  }

                }
                //print(currentIndex)
                //print(state.colors[state.colors.firstIndex(where: {$0.color.id == state.selectedColorId}) ?? 0].color.exteriorImages[currentIndex])
              }
          )
        }
      }
    }
  }
}
