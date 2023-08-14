//
//  ExternalSelectionView.swift
//  Catalog
//
//  Created by Jung peter on 8/14/23.
//

import SwiftUI

struct ExternalSelectionContainerView: View {

    var body: some View {
      VStack {
        Rectangle()
          .fill(.blue)
        Spacer().frame(height: 20)
        VStack(alignment: .leading, spacing: 0) {
          Text("외장 색상을 선택해주세요")
            .catalogFont(type: .HeadKRMedium18)
          Spacer().frame(height: 8)
          ExternalColorSelectionHorizontalList(height: UIScreen.main.bounds.height * 177 / 812)
          Spacer()
        }
        .padding(.horizontal, 20)
      }
    }
}

struct ExternalSelectionContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ExternalSelectionContainerView()
    }
}
