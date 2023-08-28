//
//  ExternalImageView.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/24.
//

import SwiftUI
struct ExteriorImageView {
  var intent: ExteriorSelectionIntentType
  var viewState: ExteriorSelectionModel.ViewState
  @SwiftUI.State var currentIndex: Int = 0
  @SwiftUI.State var beforeIndex: Int = 0
}

extension ExteriorImageView: View {
  var body: some View {
    GeometryReader { proxy in
      VStack {
        Spacer()
        ZStack {
          VStack {
            Spacer()
              .frame(height: CGFloat(130).scaledHeight)
            ZStack {
              Image("shadow_360")
              VStack {
                Spacer()
                  .frame(height: CGFloat(33).scaledHeight)
                Text("360°")
                  .catalogFont(type: .HeadKRMedium14)
                  .foregroundColor(Color.gray900)
                  .frame(width: CGFloat(31.33).scaledWidth, height: CGFloat(16).scaledHeight)
                  .background(Color.white)
              }
            }
          }
          if viewState.colors.isEmpty {
            EmptyView()
          } else {
            VStack {
              AsyncCachedImage(url: viewState.colors[viewState.currentSelectedIndex].color.exteriorImages[currentIndex]) { image in
                image
                  .resizable()
                  .frame(height: CGFloat(198).scaledHeight, alignment: .bottom)
              }
            placeholder: {
              VStack {
                if (viewState.images[viewState.currentSelectedIndex].count == 60) {
                  Image(data: viewState.images[viewState.currentSelectedIndex][beforeIndex])?
                    .resizable()
                    .frame(height: CGFloat(198).scaledHeight, alignment: .bottom)
                  
                } else {
                  LoadingComponent()
                }
              }
            }
            }
          }
        }
        .frame(height: CGFloat(198).scaledHeight, alignment: .bottom)
      }
      
      .gesture(
        DragGesture()
          .onChanged { drag in
            print(viewState.currentSelectedIndex)
            let count = viewState.colors[viewState.currentSelectedIndex].color.exteriorImages.count
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
          }
      )
    }
  }
}

