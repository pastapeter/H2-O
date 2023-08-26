//
//  HMGTag.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/14.
//

import SwiftUI

struct HMGTag: View {
    var body: some View {
      VStack {
        Text("HMG Data")
          .catalogFont(type: .HeadENMedium10)
          .foregroundColor(.white)
          .frame(width: 70, height: 21)
          .background(Color.activeBlue)
      }
    }
}

struct HMGTag_Previews: PreviewProvider {
    static var previews: some View {
        HMGTag()
    }
}
