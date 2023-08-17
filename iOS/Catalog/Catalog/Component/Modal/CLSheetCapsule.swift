//
//  CLSheetCapsule.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/17.
//

import SwiftUI

struct CLSheetCapsule: View {
    let height: CGFloat
    var body: some View {
      Capsule()
        .fill(Color.gray300)
        .frame(width: 39, height: height)
        .padding(.bottom, 5)
        .padding(.top, 5)
    }
}

struct CLSheetCapsule_Previews: PreviewProvider {
    static var previews: some View {
      CLSheetCapsule(height: 4)
    }
}
