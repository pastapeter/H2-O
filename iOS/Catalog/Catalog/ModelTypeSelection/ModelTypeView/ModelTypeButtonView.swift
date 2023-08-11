//
//  ModelTypeButtonView.swift
//  Catalog
//
//  Created by Jung peter on 8/11/23.
//

import SwiftUI

struct ModelTypeButtonView: View {
    var body: some View {
      VStack(alignment: .leading) {
        Text("38%의 선택")
          .foregroundColor(.gray500)
          .catalogFont(type: .HeadKRMedium14)
        Text("디젤 2.2")
          .foregroundColor(.gray600)
          .catalogFont(type: .TextKRMedium16)
        HStack {
          Text("+0 원")
            .foregroundColor(.gray600)
            .catalogFont(type: .TextKRMedium16)
          Spacer()
          Image("check").renderingMode(.template).foregroundColor(.gray200)
        }
      }
      .padding(EdgeInsets(top: 8, leading: 13, bottom: 7, trailing: 8))
      .background(.white)
      .cornerRadius(4)
    }
}

struct ModelTypeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ModelTypeButtonView()
    }
}
