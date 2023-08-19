//
//  HMGDataWithHorizontalGraphView.swift
//  Catalog
//
//  Created by Jung peter on 8/12/23.
//

import SwiftUI

struct HMGModelTypeState: Equatable {
 
  var engineOutput: MaxOutputFromEngine
  var torque: MaxTorqueFromEngine
  var enginePercent: Double
  var torquePercent: Double

}

struct HMGDataWithHorizontalGraphView: View {

  var state: HMGModelTypeState

}

extension HMGDataWithHorizontalGraphView {

  var body: some View {
    VStack(alignment: .leading) {
      HStack(alignment: .bottom) {
        Text("최고출력(PS/rpm)")
          .catalogFont(type: .TextKRMedium10)
          .foregroundColor(.gray600)
        Spacer()
        Text("\(state.engineOutput.output.toRPMMetricDescription())/\(state.engineOutput.maxRPM)")
          .catalogFont(type: .HeadKRRegular22)
      }
      Spacer().frame(height: 5)
      BarHorizontalView(percent: state.enginePercent)

      HStack(alignment: .bottom) {
        Text("최대토크(kgf・m/rpm)")
          .catalogFont(type: .TextKRMedium10)
          .foregroundColor(.gray600)
        Spacer()
        Text("\(state.torque.torque.toRPMMetricDescription())/\(state.torque.minRPM)-\(state.torque.maxRPM)")
          .catalogFont(type: .HeadKRRegular22)
      }
      Spacer().frame(height: 5)
      BarHorizontalView(percent: state.torquePercent)
        .frame(height: 4)
    }
  }

}

fileprivate extension Double {
  
  func toRPMMetricDescription() -> String {
    
    if Double(Int(self)) == self {
      return "\(Int(self))"
    } else {
      return String(format: "%.1f", self)
    }
      
  }
  
}
