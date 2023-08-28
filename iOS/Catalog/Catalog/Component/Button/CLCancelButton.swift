//
//  CLCancelButton.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/10.
//

import SwiftUI

struct CLCancelButton: View {

    var cancelAction: (() -> Void)
    var (width, height): (CGFloat?, CGFloat?)
    var padding: EdgeInsets?

    var body: some View {
        HStack {
            Spacer()
            Button {
                cancelAction()
            } label: {
                Image("cancel")
                    .frame(width: width ?? 24, height: height ?? 24)
            }
            .padding(padding ?? EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

struct CLCancelButton_Previews: PreviewProvider {
    static var previews: some View {
        CLCancelButton(cancelAction: { print("취소 버튼 클릭") },
                       width: 24,
                       height: 24,
                       padding: EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
    }
}

extension CLCancelButton {
    init(cancelAction: @escaping (() -> Void)) {
        self.cancelAction = cancelAction
    }
}
