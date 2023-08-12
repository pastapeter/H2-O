//
//  ModelPopUp.swift
//  Catalog
//
//  Created by Jung peter on 8/12/23.
//

import SwiftUI

struct ModelPopUp: View {
    var body: some View {
      ZStack {
        ModalPopUpComponent(submitAction: { }) {
          ModelContentView(state: .mock())
        }
        .cornerRadius(4)
      }
    }
}

struct ModelPopUp_Previews: PreviewProvider {
    static var previews: some View {
        ModelPopUp()
    }
}
