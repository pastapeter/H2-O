//
//  CLListText.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/10.
//

import SwiftUI

struct CLListText: View {

    var title: String
    var name: String
    var price: CLPrice
    var body: some View {
        ZStack {
            HStack(spacing: 8) {
                HStack {
                    Text(title)
                        .catalogFont(type: .TextKRRegular14)
                        .foregroundColor(Color.gray500)
                    Spacer()
                }
                .frame(width: 68)
                HStack {
                    Text(name)
                        .catalogFont(type: .TextKRMedium14)
                        .foregroundColor(Color.gray900)
                    Spacer()
                }
                .frame(width: 160)
                Spacer()
            }
            HStack {
                Spacer()
                Text(price.signedDescription)
                    .catalogFont(type: .TextKRRegular14)
                    .foregroundColor(Color.gray900)
            }
        }
    }
}
