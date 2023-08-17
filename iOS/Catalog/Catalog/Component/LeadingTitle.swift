//
//  LeadingTitle.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/17.
//

import SwiftUI

struct LeadingTitle: View {
    let title: String
    var body: some View {
      HStack {
        Text(title)
          .catalogFont(type: .HeadKRMedium16)
        Spacer()
      }
      .padding(.leading, 20)
      .padding(.vertical, 12)
    }
}

struct LeadingTitle_Previews: PreviewProvider {
    static var previews: some View {
      LeadingTitle(title: "트림을 선택해주세요")
    }
}
