//
//  ModelSystemContent.swift
//  Catalog
//
//  Created by Jung peter on 8/11/23.
//

import SwiftUI

struct ModelContentView: View {

  private var state: ModelTypeDetailState
  private var content: ModelTypeContent {
    state.content
  }

  init(state: ModelTypeDetailState) {
    self.state = state
  }

}

extension ModelContentView {

  var body: some View {
    VStack(alignment: .leading) {
      VStack {
        Image("gasoline3")
          .resizable()
          .frame(height: UIScreen.main.bounds.height * (180 / 812))
        VStack(alignment: .leading) {
          HStack {
            Text(content.title)
              .catalogFont(type: .HeadKRMedium18)
              .foregroundColor(.gray900)
            Spacer()
            Text("\(Text("\(content.frequency)%").foregroundColor(.activeBlue))의 선택")
              .catalogFont(type: .TextKRMedium12)
          }
          Text(content.description)
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

struct ModelContentView_Previews: PreviewProvider {
    static var previews: some View {
      ModelContentView(state: .init(content: .mock(), hmgData: .mock()))
    }
}
