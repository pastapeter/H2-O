//
//  TrimSelectButton.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/02.
//

import SwiftUI

struct CLButton: View {
    
    enum CLButtonState {
        case `default`
        case isClicked
        case inActive
    }
    
    @Binding var buttonState: CLButtonState
    @State var subText: String?
    @State var mainText: String
    @State var inActiveText: String?
    @State var height: CGFloat
    @State var width: CGFloat?
    let buttonAction: () -> Void
    
    var body: some View {
        Button {
            buttonState = .isClicked
            buttonAction()
        } label: {
            VStack {
                if subText != nil {
                    Text(subText ?? "")
                        .catalogFont(type: .TextKRRegular12)
                        .foregroundColor(Color.white)
                }
                Text((buttonState == .default || buttonState == .isClicked) ? mainText : (inActiveText ?? ""))
                    .catalogFont(type: .HeadKRMedium16)
                    .foregroundColor(Color.white)
            }
            .frame(maxWidth: width ?? .infinity, maxHeight: height)
            .background(buttonState == .isClicked ?
                        Color.primary800 : buttonState == .inActive ? Color.gray300 : Color.primary700)
            .ignoresSafeArea()
        }
        .disabled(buttonState == .inActive)
        .buttonStyle(.plain)
    }
}

struct CLButton_Previews: PreviewProvider {
    static var previews: some View {
        @State var buttonState: CLButton.CLButtonState = .inActive
        CLButton(buttonState: $buttonState,
                 mainText: "Le Blanc 선택하기",
                 inActiveText: "옵션을 선택해 추가해보세요.",
                 height: 52,
                 buttonAction: { print("clicked") })
    }
}
