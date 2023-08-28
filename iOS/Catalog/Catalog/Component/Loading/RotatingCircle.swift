//
//  RotatingCircle.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/22.
//

import SwiftUI

struct RotatingCircle {
  @State var isRotating: Bool = true
  @State private var animateStart = false
  @State private var animateEnd = true
}
extension RotatingCircle: View {
  
  var body: some View {
    ZStack {
      Image("loading_small_circle")
      Image("loading")
      Image("loading_circle")
      Image("loading_big_circle")
      Circle()
        .trim(from: animateStart ? 1/2 : 1/9,to: animateEnd ? 2/5 : 1)
        .stroke(lineWidth: 3)
        .rotationEffect(.degrees(isRotating ? 360 : 0))
        .frame(width: 54, height: 54)
        .foregroundColor(Color.activeBlue)
        .onAppear {
          withAnimation(Animation
            .linear(duration: 1)
            .repeatForever(autoreverses: false)) {
              self.isRotating.toggle()
            }
          withAnimation(Animation
            .linear(duration: 1)
            .delay(0.5)
            .repeatForever(autoreverses: true)) {
              self.animateStart.toggle()
            }
          withAnimation(Animation
            .linear(duration: 1)
            .delay(1)
            .repeatForever(autoreverses: true)) {
              self.animateEnd.toggle()
            }
        }
    }
  }
}

struct RotatingCircle_Previews: PreviewProvider {
  static var previews: some View {
    @State var isRotating: Bool = true
    @State var animateStart = false
    @State var animateEnd = true
    RotatingCircle()
  }
}
