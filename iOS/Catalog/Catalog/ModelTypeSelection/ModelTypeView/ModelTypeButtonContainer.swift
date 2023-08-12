//
//  ModelTypeButtonContainer.swift
//  Catalog
//
//  Created by Jung peter on 8/12/23.
//

import SwiftUI

struct ModelTypeButtonContainer: View {

  @State var isLeftChoice = true
  @State var isRightChoice = false

}

extension ModelTypeButtonContainer {
  var body: some View {
    HStack {
      ModelTypeButtonView(isSelected: $isLeftChoice)
      ModelTypeButtonView(isSelected: $isRightChoice)
    }
  }
}

struct ModelTypeButtonContainer_Previews: PreviewProvider {
    static var previews: some View {
        ModelTypeButtonContainer()
    }
}
