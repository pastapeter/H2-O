//
//  ModelTypeButtonContainer.swift
//  Catalog
//
//  Created by Jung peter on 8/12/23.
//

import SwiftUI

struct ModelTypeButtonContainer: View {
  @State var options: [ModelTypeOptionState]
  var action: (Int) -> Void
}

extension ModelTypeButtonContainer {
  var body: some View {
    HStack {
      ForEach(options.indices, id: \.self) { i in
        ModelTypeButtonView(state: options[i], action: { id in
          if let index = options.firstIndex(where: { $0.id == id }) {
            action(id)
            toggle(with: index)
          }
        })
      }
    }
  }
}

extension ModelTypeButtonContainer {
  func toggle(with index: Int) {
    for i in options.indices {
      if i == index {
        options[i].isSelected = true
      } else {
        options[i].isSelected = false
      }
    }
  }
}

