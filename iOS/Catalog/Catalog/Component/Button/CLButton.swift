//
//  CLButton.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/02.
//

import SwiftUI

struct CLButton: View {

    var mainText: String
    var subText: String?
    var height: CGFloat
    var width: CGFloat?
    var backgroundColor: Color
    let buttonAction: () -> Void

    var body: some View {
        Button {
            buttonAction()
        } label: {
            VStack {
                if subText != nil {
                    Text(subText ?? "")
                        .catalogFont(type: .TextKRRegular12)
                        .foregroundColor(Color.white)
                }
                Text(mainText)
                    .catalogFont(type: .HeadKRMedium16)
                    .foregroundColor(Color.gray100)
            }
            .frame(maxWidth: width ?? .infinity, maxHeight: height)
            .background(backgroundColor)
            .ignoresSafeArea()
        }
        .buttonStyle(.plain)
    }
}
