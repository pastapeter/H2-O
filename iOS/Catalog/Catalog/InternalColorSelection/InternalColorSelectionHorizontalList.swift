//
//  InternalColorSelectionHorizontalList.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import SwiftUI

struct InternalColor: Equatable, Hashable {
  var id: Int
  var name: String
  var choiceRatio: CLNumber
  var price: CLNumber
  var fabricImageURL: URL?
  var bannerImageURL: URL?
}

struct InternalColorState: Equatable {
  var isSelected: Bool
  var color: InternalColor
}

struct ColorContent {
  enum ColorType {
    case `internal`, external
  }

  var type: ColorContent.ColorType
  var id: Int
  var name: String
  var choiceRatio: CLNumber
  var price: CLNumber

}

protocol ColorStateProtocol {
  var isSelected: Bool { get set }
  var color: ColorContent { get }
}

struct ColorSelectionHorizontalList: View {

  var state: [InternalColorState]
  var height: CGFloat = 400

  var body: some View {
    VStack(alignment: .leading) {
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack {
          ForEach(state.indices, id: \.self) { i in
            InternalColorSelectionView(state: state[i], action: { })
          }
        }
      }
      .frame(maxHeight: height)
    }
  }

}

struct InternalColorSelectionHorizontalList: View {

  var state: [ColorState]
  var height: CGFloat = 400

    var body: some View {
      VStack(alignment: .leading) {
        ScrollView(.horizontal, showsIndicators: false) {
          LazyHStack {
            ForEach(state.indices, id: \.self) { i in
              ColorSelectionView(state: state[i]) {
                
              }
            }
          }
        }
        .frame(maxHeight: height)
      }
    }

}
