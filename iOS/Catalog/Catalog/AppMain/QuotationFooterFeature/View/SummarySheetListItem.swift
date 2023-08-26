//
//  SummarySheetListItem.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/10.
//

import SwiftUI

struct SummarySheetListItem: View {

    var title: String
    var info: SummaryQuotationInfo
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
                  Text(info.name)
                        .catalogFont(type: .TextKRMedium14)
                        .foregroundColor(Color.gray900)
                    Spacer()
                }
                .frame(width: 160)
                Spacer()
            }
            HStack {
                Spacer()
              Text(info.price.signedWon)
                    .catalogFont(type: .TextKRRegular14)
                    .foregroundColor(Color.gray900)
            }
        }
    }
}
