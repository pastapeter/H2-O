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
  @State var showAlert: Bool = false
  
}

extension DetailQuotationItem: View {
  
  var body: some View {
    HStack {
      
      // 이미지
      AsyncCachedImage(url: info.image) { image in
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
            intent.send(action: .onTapDeleteButton(optionId: info.id))
          } label: {
            Text("삭제하기").catalogFont(type: .HeadKRMedium14).foregroundColor(Color.sand)
          }
        } else {
          Button {
            intent.send(action: .onTapModifyButton(navigationIndex: info.index, title: info.title))
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

fileprivate extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
