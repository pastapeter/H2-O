//
//  LeadingTitle.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/17.
//

import SwiftUI

extension View {
  @ViewBuilder
  func leadingTitle() -> some View {
    HStack {
      self
      Spacer()
    }
    .padding(.leading, 20)
  }
}
