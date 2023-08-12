//
//  ModelTypeModal.swift
//  Catalog
//
//  Created by Jung peter on 8/11/23.
//

import SwiftUI

class ModalPopUpContent: Equatable {

  let value: String

  init(value: String) {
      self.value = value
  }

  static func == (lhs: ModalPopUpContent, rhs: ModalPopUpContent) -> Bool {
      lhs.value == rhs.value
  }

}

struct ModalPopUpState {
  var middle: ModalPopUpContent?
}

struct ModelTypeModal: View {
  @State var PopupDetails = ModalPopUpState()
}

extension ModelTypeModal {
  var body: some View {
      Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
  }
}

struct ModelTypeModal_Previews: PreviewProvider {
    static var previews: some View {
        ModelTypeModal()
    }
}
