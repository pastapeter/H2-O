  //
//  OptionModalContentView.swift
//  Catalog
//
//  Created by Jung peter on 8/21/23.
//

import SwiftUI

struct OptionModalContentView: View {
  
  var state: DetailOptionInfo
  @State var isFold = false
  
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {
        OptionModalImageView(imageURL: state.image, hashTags: state.hashTags)
        Spacer().frame(height: 12)
        ExpandableText(text: state.description ?? "", isFold: $isFold)
          .font(CatalogTextType.TextKRRegular12.font)
          .foregroundColor(.gray800)
          .expandButton(TextSet(text: "더보기", font: .TextKRRegular12, color: .gray800))
          .lineLimit(4)
          .fixedSize(horizontal: false, vertical: true)
          .padding(.horizontal, 16)
          .frame(height: CGFloat(104).scaledHeight, alignment: .top)
          
        if !isFold {
          Group {
            if let hmgData = state.hmgData {
              HMGDataBannerComponent {
                OptionModalHMGDataView(state: hmgData)
              }
              .frame(height: CGFloat(145).scaledHeight)
            } else {
              Rectangle()
                .fill(.clear)
            }
          }
        } else {
          Spacer()
        }
      }
    }
}
