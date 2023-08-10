//
//  CLLinearGradient.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/09.
//

import SwiftUI

struct CLLinearGradient: View {

    var height: CGFloat
    var startPoint: UnitPoint
    var endPoint: UnitPoint
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.white, Color("Transparent")]), startPoint: startPoint, endPoint: endPoint)
            .frame(height: height)
    }
}

struct CLLinearGradient_Previews: PreviewProvider {
    static var previews: some View {
        CLLinearGradient(height: 29, startPoint: .top, endPoint: .bottom)
    }
}
