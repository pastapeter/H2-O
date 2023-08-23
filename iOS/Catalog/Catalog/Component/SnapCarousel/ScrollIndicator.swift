//
//  ScrollIndicator.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/23.
//

import SwiftUI

struct ScrollIndicator {
  let spacing: CGFloat
  let count: Int
  let bigWidth: CGFloat
  let smallWidth: CGFloat
  let height: CGFloat
  let bigScaleEffect: CGFloat
  let smallScaleEffect: CGFloat
  let bottomPadding: CGFloat
  @Binding var currentIndex: Int
}
extension ScrollIndicator: View {
  
  var body: some View {
    
    HStack(spacing: spacing) {
      ForEach(0..<count) { (index: Int) in
        Capsule()
          .fill(currentIndex == index ? Color.primary0 : Color.gray200)
          .frame(width: (currentIndex == index ? bigWidth : smallWidth), height: height)
          .scaleEffect((currentIndex == index) ? bigScaleEffect : smallScaleEffect)
          .animation(.spring(), value: currentIndex == index)
      }
    }
    .padding(.bottom, CGFloat(bottomPadding).scaledHeight)
  }
}
