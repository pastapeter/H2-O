//
//  CLPopUp.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/05.
//

import SwiftUI

struct CLPopUp: View {
    @Binding var showPopUp: Bool
    let padding: EdgeInsets // 서동북남
    let rectangleImage: String
    let width: CGFloat
    let height: CGFloat
    let title: AttributedString
    var accentText: String?
    let description: String
    var body: some View {
        DimmedZStack(padding: padding) {
            VStack {
                ZStack(alignment: .top) {
                    HStack {
                        Text(attributedString)
                            .catalogFont(type: .HeadKRMedium14)
                        Spacer()
                    }
                    CLCancelButton {
                        showPopUp = false
                    }
                }
                .padding(.bottom, 5)
                HStack {
                    Divider()
                        .frame(width: 36, height: 1)
                        .background(Color.primary200)
                    Spacer()
                }
                .padding(.vertical, 5)
                Text(description)
                    .catalogFont(type: .TextKRRegular12)
                    .foregroundColor(Color.primary500)
                    .padding(.top, 5)
            }
            .frame(width: width, height: height)
            .padding(.bottom, 5)
            .background(Image(rectangleImage))
        }
    }
}

extension CLPopUp {
    @available(iOS 15, *)
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
        @State var showPopUp: Bool = true
        CLPopUp(   showPopUp: $showPopUp,
                   padding: EdgeInsets(top: 244, leading: 33, bottom: 332, trailing: 86),
                        rectangleImage: "guide_popup_rectangle",
                        width: 214,
                        height: 236,
                        title: "현대자동차만이\n제공하는 실활용 데이터로\n합리적인 차량을 만들어 보세요.",
                        accentText: "실활용 데이터",
                        description: "HMG Data 마크는 Hyundai Motor Group\n에서만 제공하는 데이터입니다.\n주행 중 운전자들이 실제로 얼마나 활용하는지를\n 추적해 수치화한 데이터 입니다.")
    }
}
