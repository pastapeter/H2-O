//
//  CLToggle.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/09.
//

import SwiftUI

struct CLToggle: View {

    @Binding var isLeft: Bool
    var body: some View {
        Capsule()
            .stroke(Color.gray100)
            .background(Capsule().foregroundColor(Color.white))
            .frame(width: 154, height: 44)
            .overlay(
                ZStack {
                    HStack {
                        if !isLeft {
                            Spacer().frame(width: 78)
                        }
                        Capsule(style: .continuous)
                            .fill(Color.primary0)
                            .frame(width: 72, height: 36)
                            .animation(.linear, value: isLeft)
                        if isLeft {
                            Spacer().frame(width: 78)
                        }
                    }

                    HStack(spacing: 4) {
                        Button {
                            isLeft = true
                        } label: {
                            Capsule(style: .continuous)
                                .fill(Color("Transparaent"))
                                .frame(width: 72, height: 36)
                                .overlay(
                                    Text("외장")
                                        .catalogFont(type: isLeft ? .TextKRMedium14 : .TextKRRegular14)
                                        .foregroundColor(isLeft ? Color("background2") : Color.gray400)
                                )
                        }
                        .buttonStyle(.plain)
                        Button {
                            isLeft = false
                        } label: {
                            Capsule(style: .continuous)
                                .fill(Color("Transparaent"))
                                .frame(width: 72, height: 36)
                                .overlay(
                                    Text("내장")
                                        .catalogFont(type: isLeft ? .TextKRRegular14 : .TextKRMedium14)
                                        .foregroundColor(isLeft ? Color.gray400 : Color("background2"))
                                )
                        }
                        .buttonStyle(.plain)
                    }

                }

            )
    }
}

struct CLToggle_Previews: PreviewProvider {
    static var previews: some View {
        @State var isLeft: Bool = true
        CLToggle(isLeft: $isLeft)
    }
}
