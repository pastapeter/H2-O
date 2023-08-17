//
//  QuotationCompleteView.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/17.
//

import SwiftUI

struct QuotationCompleteView {
  var quotation = Quotation.shared
  let totalHeight: CGFloat = 534
  var (positionX, positionY): (CGFloat, CGFloat) = (0, 0)
  @SwiftUI.State var isExternal: Bool = true
  @State var showSheet: Bool = false
}

extension QuotationCompleteView: View {
  var body: some View {
    VStack {
      ZStack {
        if isExternal {
            QuotationExteriorView()
        } else {
            QuotationInteriorView()
        }
        VStack {
          Spacer()
          CLToggle(isLeft: $isExternal)
            .padding(.vertical, 8)
        }
      }
      QuotationSheetTop()
        .gesture(
          DragGesture()
            .onChanged { gesture in
             if gesture.translation.height < 20 {
                showSheet = true
              }
            }
          )
    }
    .sheet(isPresented: $showSheet) {
      QuotationCompleteSheet()
    }

  }
}

struct QuotationCompleteView_Previews: PreviewProvider {
  static var previews: some View {
    QuotationCompleteView()
  }
}

struct ScrollOffsetKey: PreferenceKey {
  static var defaultValue: CGFloat = .zero
  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value += nextValue()
  }
}
