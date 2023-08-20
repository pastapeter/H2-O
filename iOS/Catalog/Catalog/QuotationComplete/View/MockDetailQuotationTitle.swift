//
//  MockDetailQuotationTitle.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/18.
//

import Foundation
import SwiftUI

struct MockDetailQuotationTitle: View {
    var title: String
    @State var isFloating: Bool = false
    var body: some View {
      ZStack {
        Text(title).catalogFont(type: .HeadKRMedium16).leadingTitle()
        HStack {
          Spacer()
          Button {
            isFloating.toggle()
          } label: {
            isFloating ? Image( "black_arrow_up") : Image( "black_arrow_down")
          }
          .buttonStyle(.plain)
          .padding(.trailing, 20)
        }
      }
      .frame(height: 48)
      .background(Color("background2"))
    }
}
