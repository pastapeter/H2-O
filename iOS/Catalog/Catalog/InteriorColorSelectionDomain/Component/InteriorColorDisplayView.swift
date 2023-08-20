//
//  InternalColorDisplayView.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import SwiftUI

struct InteriorColorDisplayView: ColorContentable {

  var isSelected: Bool
  var color: CarColorType

  var body: some View {
    imageDisplayView()
  }
  
  @ViewBuilder
  private func imageDisplayView() -> some View {
    GeometryReader { proxy in
      switch color {
      case .interior(let fabricImageURL, _):
        AsyncImage(url: fabricImageURL) { image in
        image
          .resizable()
          .frame(height: proxy.size.height)
      } placeholder: {
        ProgressView()
        }
      case .exterior(_):
        EmptyView()
      }
    }
  }

}
