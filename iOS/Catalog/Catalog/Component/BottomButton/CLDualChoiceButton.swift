//
//  TwoBottomButtonView.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/03.
//

import SwiftUI

struct CLDualChoiceButton: View {
    @State var leftText: String
    @State var rightText: String
    @State var height: CGFloat
    @State var width: CGFloat?
    let leftAction: () -> Void
    let rightAction: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            Button {
                leftAction()
            } label: {
                dualChoiceButtonLabel(text: leftText, width: width, height: height, backGroundColor: Color.gray300)
            }
            .buttonStyle(.plain)
            Button {
                rightAction()
            } label: {
                dualChoiceButtonLabel(text: rightText, width: width, height: height, backGroundColor: Color.primary700)
            }
            .buttonStyle(.plain)
        }
    }
}

struct CLDualChoiceButton_Previews: PreviewProvider {
    static var previews: some View {
        CLDualChoiceButton(leftText: "취소",
                           rightText: "완료",
                           height: 52,
                           leftAction: { print("left")},
                           rightAction: { print("right")})
    }
}

extension CLDualChoiceButton {
    @ViewBuilder
    func dualChoiceButtonLabel(text: String, width: CGFloat?, height: CGFloat, backGroundColor: Color) -> some View {
        Text(text)
            .catalogFont(type: .HeadKRMedium16)
            .frame(maxWidth: width == nil ? .infinity / 2 : (width ?? 0) / 2, minHeight: height)
            .background(backGroundColor)
            .foregroundColor(Color.white)
    }
}
