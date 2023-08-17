//
//  QuotationExternalView.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/17.
//

import SwiftUI

struct QuotationExteriorView: View {
  var quotation = Quotation.shared
  let modalTopHeight: CGFloat = 30
  let titleTopPadding: CGFloat = 177
  let externalImageHeight: CGFloat = 222

    var body: some View {
      VStack {
        Spacer().frame(height: titleTopPadding)
        Text(quotation.state.quotation?.trim.name ?? "")
          .catalogFont(type: .HeadKRBold65)
          .foregroundColor(.white)
        AsyncImage(url: quotation.state.quotation?.trim.externalImage) { image in
          image
            .resizable()
            .frame(maxWidth: .infinity, maxHeight: externalImageHeight)
        } placeholder: {
          EmptyView()
        }
        Spacer()
      }
      .background(
        Image("QuotationCompleteBackground")
          .resizable()
      )
    }
}

struct QuotationExternalView_Previews: PreviewProvider {
    static var previews: some View {
        QuotationExteriorView()
    }
}
