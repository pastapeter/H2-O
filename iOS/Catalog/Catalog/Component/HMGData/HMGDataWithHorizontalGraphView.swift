//
//  HMGDataWithHorizontalGraphView.swift
//  Catalog
//
//  Created by Jung peter on 8/12/23.
//

import SwiftUI

struct HMGModelTypeState: Equatable {
 
  var EngineOutput: MaxOutputFromEngine
  var Torque: MaxTorqueFromEngine

}

struct HMGDataWithHorizontalGraphView: View {

  var state: HMGModelTypeState
  @State var percent: Double = 0.5

}

extension HMGDataWithHorizontalGraphView {

  var body: some View {
    VStack(alignment: .leading) {
      HStack(alignment: .bottom) {
        Text("최고출력(PS/rpm)")
          .catalogFont(type: .TextKRMedium10)
          .foregroundColor(.gray600)
        Spacer()
        Text("\(state.EngineOutput.output)/\(state.EngineOutput.maxRPM)")
          .catalogFont(type: .HeadKRRegular22)
      }
      Spacer().frame(height: 5)
      BarHorizontalView(percent: $percent)

      HStack(alignment: .bottom) {
        Text("최대토크(kgf・m/rpm)")
          .catalogFont(type: .TextKRMedium10)
          .foregroundColor(.gray600)
        Spacer()
        Text("\(state.Torque.torque)/\(state.Torque.minRPM)-\(state.Torque.maxRPM)")
          .catalogFont(type: .HeadKRRegular22)
      }
      Spacer().frame(height: 5)
      BarHorizontalView(percent: $percent)
        .frame(height: 4)
    }
  }

}

