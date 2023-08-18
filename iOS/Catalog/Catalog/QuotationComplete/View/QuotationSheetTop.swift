//
//  QuotationSheetTop.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/17.
//

import SwiftUI

struct QuotationSheetTop: View {
    var body: some View {
      VStack {
        CLSheetCapsule(height: 4)
      }
      .frame(maxWidth: .infinity, maxHeight: 30)
      .background(
        Rectangle()
          .fill(.white)
          .cornerRadius(20, corners: [.topLeft, .topRight])
          .shadow(radius: 1, x: 0, y: -1)
      )
    }
}

struct QuotationSheetTop_Previews: PreviewProvider {
    static var previews: some View {
        QuotationSheetTop()
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

private struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
