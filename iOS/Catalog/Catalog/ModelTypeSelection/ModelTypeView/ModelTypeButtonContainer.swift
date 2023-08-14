//
//  ModelTypeButtonContainer.swift
//  Catalog
//
//  Created by Jung peter on 8/12/23.
//

import SwiftUI

struct ModelTypeButtonContainer: View {
  var intent: ModelTypeIntentType
  var options: [OptionState]
}

extension ModelTypeButtonContainer {
  var body: some View {
    HStack {
      ForEach(options, id: \.self) { option in
        ModelTypeButtonView(state: option, action: { id in
          if let index = options.firstIndex(where: { $0.id == id }) {
            intent.send(action: .onTapOptions(index: index))
          }
        })
      }
    }
  }
}

struct ModelTypeButtonContainer_Previews: PreviewProvider {
    static var previews: some View {
      ModelTypeButtonContainer(intent: ModelTypeIntent(initialState: ModelTypeIntent.State()), options: [])
    }
}
