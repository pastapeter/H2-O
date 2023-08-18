//
//  DetailQuotationList.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/17.
//

 import SwiftUI

 struct DetailQuotationList: View {
  var quotation: SummaryCarQuotation
  @State var modeltypeFloating = true
  @State var colorFloating = false
  @State var optionFloating = false

  var body: some View {
    VStack {
      Section(header: DetailQuotationTitle(title: "모델타입", isFloating: $modeltypeFloating)) {
        if modeltypeFloating {
          VStack {
            ForEach([quotation.powertrain, quotation.bodytype, quotation.drivetrain], id: \.self) { modeltype in
              DetailQuotationItem(info: modeltype)
            }
          }
          .coordinateSpace(name: "modeltype")
        }
      }
      Section(header: DetailQuotationTitle(title: "색상", isFloating: $colorFloating)) {
        if colorFloating {
          VStack {
            ForEach([quotation.externalColor, quotation.internalColor], id: \.self) { color in
              DetailQuotationItem(info: color)
            }
          }
          .coordinateSpace(name: "color")
        }
      }
      Section(header: DetailQuotationTitle(title: "추가옵션", isFloating: $optionFloating)) {
        if optionFloating {
          VStack {
            ForEach([SummaryQuotationInfo(title: "옵션", name: "nn", price: CLNumber(500)),
                     SummaryQuotationInfo(title: "옵션", name: "nn", price: CLNumber(500)),
                     SummaryQuotationInfo(title: "옵션", name: "nn", price: CLNumber(500))], id: \.self) { option in
              DetailQuotationItem(info: option)
            }
          }.coordinateSpace(name: "option")
        }
      }
      Section(header: MockDetailQuotationTitle(title: "탁송")) { }
      Section(header: MockDetailQuotationTitle(title: "할인 및 포인트")) { }
      Section(header: MockDetailQuotationTitle(title: "면세 구분 및 등록비")) { }
      Section(header: MockDetailQuotationTitle(title: "결제수단")) { }
      Section(header: MockDetailQuotationTitle(title: "안내사항")) { }
    }
    .background(GeometryReader { geometry in
      Color.clear.preference(
        key: ScrollOffsetKey.self,
        value: geometry.frame(in: .named("model")).origin.y)
    })
    .onPreferenceChange(ScrollOffsetKey.self) { position in
      if 200...400 ~= position {
        modeltypeFloating = true
      }
      if position > UIScreen.main.bounds.height {
        modeltypeFloating = false
      }
    }.animation(.easeIn, value: modeltypeFloating)
    .background(GeometryReader { geometry in
      Color.clear.preference(
        key: ScrollOffsetKey.self,
        value: geometry.frame(in: .named("color")).origin.y)
    })
    .onPreferenceChange(ScrollOffsetKey.self) { position in
      if 200...400 ~= position {
        colorFloating = true
      }
      if position > UIScreen.main.bounds.height {
        colorFloating = false
      }
    }.animation(.easeIn, value: colorFloating)
    .background(GeometryReader { geometry in
      Color.clear.preference(
        key: ScrollOffsetKey.self,
        value: geometry.frame(in: .named("option")).origin.y)
    })
    .onPreferenceChange(ScrollOffsetKey.self) { position in
      if 200...400 ~= position {
        optionFloating = true
      }
      if position > UIScreen.main.bounds.height {
        optionFloating = false
      }
    }.animation(.easeIn, value: optionFloating)
  }
 }

private struct ScrollOffsetKey: PreferenceKey {
  static var defaultValue: CGFloat = .zero

  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value += nextValue()
  }
}
