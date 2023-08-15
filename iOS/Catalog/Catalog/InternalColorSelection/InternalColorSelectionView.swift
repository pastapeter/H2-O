//
//  InternalColorSelectionView.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import SwiftUI

struct InternalColorSelectionView: View {

  var state: InteriorColorState
  var action: () -> Void

  var body: some View {
    Button {
      action()
    } label: {
      VStack {
        HStack(alignment: .center, spacing: 0) {
          Rectangle()
            .fill(.red)
            Rectangle()
            .fill(.blue)
        }
        VStack(alignment: .leading, spacing: 0) {
          Text("\(Text(state.color.choiceRatio.description).foregroundColor(state.isSelected ? .activeBlue2 : .gray600))%가 선택했어요")
            .foregroundColor(.gray500)
            .catalogFont(type: .HeadKRMedium14)
          Text(state.color.name)
            .catalogFont(type: .HeadKRMedium16)
            .multilineTextAlignment(.leading)
            .foregroundColor(state.isSelected ? .gray900 : .gray600)
            .fixedSize(horizontal: false, vertical: true)
            .frame(height: 39, alignment: .topLeading)
          Spacer().frame(height: 6)
          HStack {
            Text(state.color.price.signedWon)
              .foregroundColor(state.isSelected ? .gray900 : .gray600)
              .catalogFont(type: .TextKRMedium16)
            Spacer()
            Image("check").renderingMode(.template).foregroundColor(state.isSelected ? .activeBlue2 : .gray200)
          }
          Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.bottom, 12)
      }
      .externalColorSelectionCardStyle(isselected: state.isSelected)
      .buttonSelected(isselected: state.isSelected)
    }
//    .buttonStyle(EmptyButtonStyle())
  }
}
