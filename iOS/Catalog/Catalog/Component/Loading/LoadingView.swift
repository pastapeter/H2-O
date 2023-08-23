//
//  LoadingView.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/22.
//

import SwiftUI

struct LoadingView {
  let (loadingViewWidth, loadingViewHeight) = (CGFloat(335).scaledWidth, CGFloat(220).scaledHeight)
  let (circleWidth, circleHeight) = (CGFloat(54).scaledWidth, CGFloat(54).scaledHeight)
  let title: String
}
extension LoadingView: View {
  var body: some View {
    DimmedZStack {
      Rectangle()
        .fill(.white)
        .frame(width: CGFloat(335).scaledWidth, height:  CGFloat(200).scaledHeight)
        .overlay {
          VStack {
            RotatingCircle()
            .frame(width: CGFloat(54).scaledWidth, height: CGFloat(54).scaledHeight)
            Text(title)
              .catalogFont(type: .TextKRMedium14)
          }
        }
    }
  }
}

struct LoadingView_Previews: PreviewProvider {
  static var previews: some View {
    LoadingView(title: "데이터를 불러오는 중입니다.")
  }
}
