//
//  ModelSystemContent.swift
//  Catalog
//
//  Created by Jung peter on 8/11/23.
//

import SwiftUI

struct ModelTypeModalContentView: View {

  private var state: ModelTypeDetailState

  init(state: ModelTypeDetailState) {
    self.state = state
  }

}

extension ModelTypeModalContentView {

  var body: some View {
    
      VStack {
        AsyncCachedImage(url: state.imageURL) { image in
          image
            .resizable()
            .frame(height: CGFloat(170).scaledHeight)
        } 
        VStack(alignment: .leading) {
          HStack {
            Text(state.title)
              .catalogFont(type: .HeadKRMedium18)
              .foregroundColor(.gray900)
            Spacer()
            if let choiceRatio = state.choiceRatio {
              Text("\(Text("\(choiceRatio.description)%").foregroundColor(.activeBlue))의 선택")
                .catalogFont(type: .TextKRMedium12)
            }
          }
          Text(state.description ?? "")
            .catalogFont(type: .TextKRRegular12)
            .foregroundColor(.gray800)
            .multilineTextAlignment(.leading)
          Spacer()
        }
        .frame(height: CGFloat(110).scaledHeight)
        .padding(.horizontal, CGFloat(20).scaledWidth)
        Spacer()
        if let hmgDataState = state.hmgData {
          HMGDataBannerComponent {
            HMGDataWithHorizontalGraphView(state: hmgDataState)
          }
          .frame(height: CGFloat(110).scaledHeight)
        }
        
      }
  }

}

