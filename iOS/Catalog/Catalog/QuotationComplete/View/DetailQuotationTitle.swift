//
//  DetailQuotationTitle.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/17.
//

import SwiftUI

struct DetailQuotationTitle: View {
    var title: String
    @Binding var isFloating: Bool
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
          .padding(.trailing, 20)
          .buttonStyle(.plain)

        }
      }
      .background(Color("background2"))
    }
}

struct DetailQuotationTitle_Previews: PreviewProvider {
    static var previews: some View {
      @State var isFloating = true
      DetailQuotationTitle(title: "모델타입", isFloating: $isFloating)
    }
}
