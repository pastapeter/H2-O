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
    switch color {
    case .interior(let fabricImageURL, _):
      AsyncCachedImage(url: fabricImageURL) { image in
      image
        .resizable()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    case .exterior(_):
      EmptyView()
    }
  }

}
