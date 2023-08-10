//
//  DimmedZStack.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/06.
//

import SwiftUI

struct DimmedZStack<Content>: View where Content: View {

    let padding: EdgeInsets
    let content: () -> Content
    init(padding: EdgeInsets = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0), @ViewBuilder content: @escaping() -> Content) {
        self.padding = padding
        self.content = content
    }

    var body: some View {
        ZStack {
            Color.gray900.ignoresSafeArea().background(.thickMaterial).opacity(0.7)
            content()
                .padding(padding)
        }
    }
}
