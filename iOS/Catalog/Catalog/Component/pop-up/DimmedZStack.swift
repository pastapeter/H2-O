//
//  DimmedZStack.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/06.
//

import SwiftUI

struct DimmedZStack<Content>: View where Content: View {

    let padding: [CGFloat]
    let content: () -> Content
    init(padding: [CGFloat] = [0, 0, 0, 0], @ViewBuilder content: @escaping() -> Content) {
        self.padding = padding
        self.content = content
    }

    var body: some View {
        ZStack {
            Color("DimmedBackground").ignoresSafeArea()
            content()
                .padding(.leading, padding[0])
                .padding(.trailing, padding[1])
                .padding(.top, padding[2])
                .padding(.bottom, padding[3])
        }
    }
}
