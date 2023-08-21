//
//  OptionModalContentView.swift
//  Catalog
//
//  Created by Jung peter on 8/21/23.
//

import SwiftUI

struct OptionModalContentView: View {
  
  var hashTags: [String]
  var description: String?
  @State var isFold = true
  
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {
        OptionModalImageView(hashTags: hashTags)
        VStack(alignment: .leading) {
          Spacer().frame(height: CGFloat(12).scaledHeight)
          Text(description ?? "")
            .catalogFont(type: .TextKRRegular12)
            .foregroundColor(.gray800)
            .multilineTextAlignment(.leading)
            .padding(.horizontal, CGFloat(16).scaledWidth)
          Spacer()
        }
        Spacer().frame(height: CGFloat(27).scaledHeight)
        HMGDataBannerComponent {
          OptionModalHMGDataView()
        }
        .frame(height: CGFloat(110).scaledHeight)
      }
    }
}

struct OptionModalContentView_Previews: PreviewProvider {
    static var previews: some View {
      OptionModalContentView(hashTags: ["장거리운전"], description: "시동이 걸린 상태에서 해당 좌석의 통풍 스위치를 누르면 표시등이 켜지면서 해당 좌석에 바람이 나오는 편의장치입니다. 시동이 걸린 상태에서 해당 좌석의 통풍 스위치를 누르면 표시등이 켜지면서 해당 좌석에 바람이 나오는 편의장치입니다.")
    }
}
