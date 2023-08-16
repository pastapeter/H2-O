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
    HStack(alignment: .center, spacing: 0) {
      Rectangle()
        .fill(.red)
        Rectangle()
        .fill(.blue)
    }
  }

}
