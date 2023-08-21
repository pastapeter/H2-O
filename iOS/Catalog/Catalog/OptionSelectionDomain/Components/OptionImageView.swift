//
//  OptionImageView.swift
//  Catalog
//
//  Created by Jung peter on 8/21/23.
//

import SwiftUI

struct OptionImageView: View {
  
  var imageURL: URL?
  var containsHmgData: Bool
  var HMGButtonAction: (() -> Void)?
  var hashTags: [String]
  
  
  
    var body: some View {
      ZStack {
        AsyncImage(url: imageURL) { image in
          image
            .resizable()
            .scaledToFill()
            .frame(height: CGFloat(128).scaledHeight)
            .clipped()
        } placeholder: {
          ProgressView()
        }
        VStack(spacing: 0) {
          HStack {
            Spacer()
            if containsHmgData {
              HMGButton(action: {
                HMGButtonAction?()
              })
            } else {
              Button(action: {}) {
                Text("상세보기")
                  .catalogFont(type: .TextKRMedium12)
              }
              .buttonStyle(DetailButtonStyle())
            }
          }
          Spacer()
          HStack {
            ForEach(hashTags.indices, id: \.self) { i in
              ImageTagView(title: hashTags[i])
            }
            Spacer()
          }
        }
        .padding(.leading, 13)
        .padding(.bottom, 8)
      }
    }
}
