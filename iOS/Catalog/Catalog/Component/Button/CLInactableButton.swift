//
//  CLInactableButton.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/10.
//

import SwiftUI

struct CLInActiveButton: View {

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
