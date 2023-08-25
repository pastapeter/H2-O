//
//  LoadingComponent.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/24.
//


import SwiftUI

struct LoadingComponent {
  let (loadingViewWidth, loadingViewHeight) = (CGFloat(335).scaledWidth, CGFloat(220).scaledHeight)
  let (circleWidth, circleHeight) = (CGFloat(54).scaledWidth, CGFloat(54).scaledHeight)
  let title: String = "데이터를 불러오는 중입니다."
}
extension LoadingComponent: View {
  var body: some View {
      Rectangle()
        .fill(.white)
        .overlay {
          VStack {
            RotatingCircle()
            .frame(width: CGFloat(circleWidth).scaledWidth, height: CGFloat(circleHeight).scaledHeight)
            Text(title)
              .catalogFont(type: .TextKRMedium14)
          }
        }
  }
}

struct LoadingComponent_Previews: PreviewProvider {
  static var previews: some View {
    LoadingComponent()
  }
}
