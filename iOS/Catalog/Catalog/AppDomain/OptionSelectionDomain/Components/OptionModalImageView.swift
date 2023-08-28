//
//  OptionModalImageView.swift
//  Catalog
//
//  Created by Jung peter on 8/21/23.
//

import SwiftUI

struct OptionModalImageView: View {
  
  var imageURL: URL?
  var hashTags: [String] = []
  
    var body: some View {
      ZStack {
        AsyncCachedImage(url: imageURL) { image in
          image
            .resizable()
            .scaledToFit()
            .frame(height: CGFloat(170).scaledHeight)
        }
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
