//
//  DetailQuotationTitle.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/17.
//

import SwiftUI

struct DetailQuotationTitle: View {
    var title: String
    @State var isFloating: Bool = false
    var body: some View {
      ZStack {
        LeadingTitle(title: title)
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
      DetailQuotationTitle(title: "모델타입")
    }
}
