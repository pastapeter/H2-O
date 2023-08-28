//
//  CLPopUp.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/05.
//

import SwiftUI

struct CLPopUp: View {
  let paddingEdge: Edge.Set
  let rectangleImage: String
  let width: CGFloat
  let height: CGFloat
  let title: AttributedString
  var accentText: String?
  let description: String
  var cancelAction: () -> Void
  var hasCancelButton: Bool
  var body: some View {

    VStack(alignment: .leading, spacing: 0) {
      ZStack(alignment: .top) {
        HStack {
          Text(attributedString)
            .catalogFont(type: .HeadKRMedium14)
          Spacer()
        }
        if hasCancelButton {
          CLCancelButton {
            cancelAction()
          }
        }
      }
        Divider()
          .frame(width: 36, height: 1)
          .background(Color.primary200)
          .padding(.top, CGFloat(16).scaledHeight)
          .padding(.bottom, CGFloat(20).scaledHeight)
      Text(description)
        .catalogFont(type: .TextKRRegular12)
        .foregroundColor(Color.primary500)
    }
    .padding(paddingEdge, 10)
    .padding(.horizontal, CGFloat(20).scaledWidth)
    .frame(width: width, height: height)
    .background(Image(rectangleImage))
  }

}

extension CLPopUp {
  var attributedString: AttributedString {
    var text = title
    guard let range = text.range(of: accentText ?? "") else { return "" }
    text.foregroundColor = Color.gray900
    text[range].foregroundColor = Color.activeBlue
    return text
  }
}

struct CLPopUp_Previews: PreviewProvider {
  static var previews: some View {
    CLPopUp(paddingEdge: .top,
            rectangleImage: "similar_quide_popup",
            width: CGFloat(250).scaledWidth,
            height: CGFloat(155.5).scaledHeight,
            title: "내 견적과 비슷한 실제 출고 견적들을\n확인하고 비교해보세요.",
            accentText: "내 견적과 비슷한 실제 출고 견적",
            description: "유사 견적이란, 내 견적과 해시태그 유사도가\n높은 다른 사람들의 실제 출고 견적이에요.",
            cancelAction: { },
            hasCancelButton: false)
  }
}
