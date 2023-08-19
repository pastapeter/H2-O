//
//  ModelSystemContent.swift
//  Catalog
//
//  Created by Jung peter on 8/11/23.
//

import SwiftUI

struct ModelContentView: View {

  private var state: ModelTypeDetailState

  init(state: ModelTypeDetailState) {
    self.state = state
  }

}

extension ModelContentView {

  var body: some View {
    
    VStack(alignment: .leading) {
      VStack {
        AsyncImage(url: state.imageURL) { image in
          image
            .resizable()
            .frame(height: CGFloat(180).scaledHeight)
        } placeholder: {
          ProgressView()
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
        }
        .padding(.top, 12)
        .padding(.horizontal, 20)
        Spacer()
        if let hmgDataState = state.hmgData {
          HMGDataBannerComponent {
            HMGDataWithHorizontalGraphView(state: hmgDataState)
          }
        }
      }
      .background(.white)
    }
  }

}

