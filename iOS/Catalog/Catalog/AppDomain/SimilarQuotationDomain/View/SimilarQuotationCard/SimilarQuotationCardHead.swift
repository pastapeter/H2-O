//
//  SimilarQuotationCardHead.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/21.
//

import SwiftUI

struct SimilarQuotationCardHead {
  
  @Binding var index: Int
  var similarQuotation: SimilarQuotation
  let trimName: String
}

extension SimilarQuotationCardHead: View {
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 0) {
        Text("\((index+1).count())번째 유사견적서")
          .catalogFont(type: .TextKRRegular12)
          .foregroundColor(Color.gray900)
        Text(trimName)
          .catalogFont(type: .HeadKRBold26)
          .foregroundColor(Color.primary700)
        HStack(spacing: 8) {
          Text(similarQuotation.powertrainName).modelTypeCardShape()
          Text(similarQuotation.bodytypeName).modelTypeCardShape()
          Text(similarQuotation.drivetrainName).modelTypeCardShape()
        }
      }
      Spacer()
    }
    .padding(.top, 24)
  }
}

fileprivate extension Int {
  func count() -> String {
    switch self {
      case 1 :  return "첫"
      case 2: return "두"
      case 3: return "세"
      case 4: return "네"
      default: return ""
    }
  }
}

fileprivate struct ModelTypeCardShape: ViewModifier {
  
  func body(content: Content) -> some View {
    content
      .foregroundColor(.gray500)
      .padding(.horizontal, 4)
      .background(Color.gray100)
  }
}

fileprivate extension Text {
  func modelTypeCardShape() -> some View {
    self
      .catalogFont(type: .TextKRRegular12)
      .modifier(ModelTypeCardShape())
  }
}
