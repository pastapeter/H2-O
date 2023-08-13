//
//  HMGDataWithHorizontalGraphView.swift
//  Catalog
//
//  Created by Jung peter on 8/12/23.
//

import SwiftUI

struct RpmData {
  var maxOutput: Int
  var output: Int
  var maxRpm: Int
  var minRpm: Int
}

struct HMGDataState {
  static func mock() -> Self {
    return HMGDataState(
      EngineOutput: RpmData(maxOutput: 202, output: 202, maxRpm: 3800, minRpm: 3800),
      Torque: RpmData(maxOutput: 45, output: 45, maxRpm: 2750, minRpm: 1750))
  }

  var EngineOutput: RpmData
  var Torque: RpmData

}

struct HMGDataWithHorizontalGraphView: View {

  var state: HMGDataState
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
        Text("\(state.EngineOutput.output)/\(state.EngineOutput.maxRpm)")
          .catalogFont(type: .HeadKRRegular22)
      }
      Spacer().frame(height: 5)
      BarHorizontalView(percent: $percent)

      HStack(alignment: .bottom) {
        Text("최대토크(kgf・m/rpm)")
          .catalogFont(type: .TextKRMedium10)
          .foregroundColor(.gray600)
        Spacer()
        Text("\(state.Torque.output)/\(state.Torque.minRpm)-\(state.Torque.maxRpm)")
          .catalogFont(type: .HeadKRRegular22)
      }
      Spacer().frame(height: 5)
      BarHorizontalView(percent: $percent)
        .frame(height: 4)
    }
  }

}

struct HMGDataWithHorizontalGraphView_Previews: PreviewProvider {
    static var previews: some View {
      HMGDataWithHorizontalGraphView(state: .mock())
    }
}
