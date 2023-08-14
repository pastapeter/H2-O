//
//  EntryGuide.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/12.
//

import SwiftUI

struct EntryGuide: View {

  @Binding var showEntryGuide: Bool
    private let horizonalPadding = (UIScreen.main.bounds.width - 310) / 2
    var body: some View {
      DimmedZStack {
        VStack(spacing: 20) {
          Spacer()
            .frame(maxHeight: .infinity)
          HStack {
            Spacer().frame(width: horizonalPadding)
            CLPopUp(   rectangleImage: "guide_popup_rectangle",
                       width: 256,
                       height: 236,
                       title: "현대자동차만이\n제공하는 실활용 데이터로\n합리적인 차량을 만들어 보세요.",
                       accentText: "실활용 데이터",
                       description: "HMG Data 마크는 Hyundai Motor Group\n에서만 제공하는 데이터입니다.\n주행 중 운전자들이 실제로 얼마나 활용하는지를\n 추적해 수치화한 데이터 입니다.",
                        cancelAction: { showEntryGuide = false})
            Spacer()
          }

          HMGDataCard(options: [HMGDatum(optionTitle: "안전 하차 보조", optionFrequency: 42),
                                  HMGDatum(optionTitle: "후측방 충돌\n경고", optionFrequency: 42),
                                  HMGDatum(optionTitle: "후방 교차\n충돌방지 보조", optionFrequency: 42)])
          .padding(.horizontal, horizonalPadding)

          GeometryReader { proxy in
            Spacer().frame(height: 100 + proxy.safeAreaInsets.bottom)
          }

        }
      }
    }
}

 struct EntryGuide_Previews: PreviewProvider {
    static var previews: some View {
      @State var showEntryGuide: Bool = true
      EntryGuide(showEntryGuide: $showEntryGuide)
    }
 }
