//
//  ModelSystemContent.swift
//  Catalog
//
//  Created by Jung peter on 8/11/23.
//

import SwiftUI

struct ModelTypeContent {

  static func mock() -> Self {
    return ModelTypeContent(title: "디젤 2.2",
                            description: "높은 토크로 파워풀한 드라이빙이 가능하며, 차급대비 연비 효율이 우수합니다.",
                            frequency: 38,
                            imageURL: nil)
  }

  var title: String
  var description: String
  var frequency: Int
  var imageURL: URL?
}

struct ModelContentView: View {

  private var state: ModelTypeContent

  init(state: ModelTypeContent) {
    self.state = state
  }

}

extension ModelContentView {

  var body: some View {
    VStack(alignment: .leading) {
      Image("gasoline3")
        .resizable()
      VStack {
        HStack {
          Text(state.title)
            .catalogFont(type: .HeadKRMedium18)
            .foregroundColor(.gray900)
          Spacer()
          Text("\(Text("\(state.frequency)%").foregroundColor(.activeBlue))의 선택")
            .catalogFont(type: .TextKRMedium12)
        }

        Text(state.description)
          .catalogFont(type: .TextKRRegular12)
          .foregroundColor(.gray800)
          .multilineTextAlignment(.leading)
        HMGDataWithHorizontalGraphView(state: .mock())
      }
      .padding(20)

    }
  }

}

struct ModelContentView_Previews: PreviewProvider {
    static var previews: some View {
      ModelContentView(state: ModelTypeContent.mock())
    }
}
