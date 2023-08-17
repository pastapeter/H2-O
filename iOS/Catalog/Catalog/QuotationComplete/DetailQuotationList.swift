//
//  DetailQuotationList.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/17.
//

import SwiftUI

struct DetailQuotationList: View {
    var body: some View {
      DetailQuotationTitle(title: "모델타입")
      DetailQuotationTitle(title: "색상")
      DetailQuotationTitle(title: "추가옵션")
    }
}

struct DetailQuotationList_Previews: PreviewProvider {
    static var previews: some View {
        DetailQuotationList()
    }
}
