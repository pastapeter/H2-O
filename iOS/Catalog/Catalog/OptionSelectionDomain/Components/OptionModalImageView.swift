//
//  OptionModalImageView.swift
//  Catalog
//
//  Created by Jung peter on 8/21/23.
//

import SwiftUI

struct OptionModalImageView: View {
  
  var hashTags = ["장거리운전", "다자녀", "안전"]
  
    var body: some View {
      ZStack {
        Image("cooling")
          .resizable()
          
        VStack(spacing: 0) {
          HStack {
            ForEach(hashTags.indices, id: \.self) { i in
              ImageTagView(title: hashTags[i])
            }
            Spacer()
          }
          .padding(.top, 8)
          Spacer()
        }
        .padding(.leading, 13)
        .padding(.bottom, 8)
      }
      .frame(height: CGFloat(170).scaledHeight)
    }
}

struct OptionModalImageView_Previews: PreviewProvider {
    static var previews: some View {
        OptionModalImageView()
    }
}
