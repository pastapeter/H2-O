//
//  SwiftUIView.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/17.
//

import SwiftUI

struct DetailQuotationItem {
  let info: SummaryQuotationInfo
  let itemHeight: CGFloat = 55
  let itemImageWidth: CGFloat = 77
  var intent: QuotationCompleteIntentType
  @Environment(\.presentationMode) var presentationMode
  
}

extension DetailQuotationItem: View {
  
  var body: some View {
    HStack {
      
      // 이미지
      AsyncImage(url: info.image) { image in
        image
          .resizable()
      } placeholder: {
        Rectangle()
          .fill(Color(hex: String(describing: info.image )))
      }
      .frame(width: itemImageWidth)
      .cornerRadius(2)
      .padding(.trailing, 16)
      // 제목 및 값
      VStack(alignment: .leading) {
        Text(info.title).catalogFont(type: .TextKRRegular14).foregroundColor(Color.gray500)
        Text(info.name).catalogFont(type: .TextKRRegular14).foregroundColor(Color.gray900)
      }
      
      Spacer()
      // 가격
      VStack(alignment: .trailing) {
        if info.isSimilarOption {
          Button {
            intent.send(action: .onTapDeleteButton)
            presentationMode.wrappedValue.dismiss()
          } label: {
            Text("삭제하기").catalogFont(type: .HeadKRMedium14).foregroundColor(Color.sand)
          }
        } else {
          Button {
            intent.send(action: .onTapModifyButton(navigationIndex: info.index))
            presentationMode.wrappedValue.dismiss()
          } label: {
            Text("수정하기").catalogFont(type: .HeadKRMedium14).foregroundColor(Color.primary0)
          }
        }
        
        Text(info.price.signedWon).catalogFont(type: .TextKRRegular14).foregroundColor(Color.gray900)
      }
    }
    .padding(.horizontal, 20)
    .frame(height: itemHeight)
  }
}
