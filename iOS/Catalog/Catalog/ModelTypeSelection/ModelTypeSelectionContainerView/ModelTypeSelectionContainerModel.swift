//
//  ModelTypeSelectionContainerModel.swift
//  Catalog
//
//  Created by Jung peter on 8/14/23.
//

import Foundation

enum ModelTypeSelectionContainerModel {

  struct State: Equatable {

    static func mock() -> Self {
      return .init(modelTypeIntents: [
        .init(),
        .init(title: "바디타입",
             imageURL: nil,
             optionStates: [
              .init(id: .init(),
                    isSelected: true,
                    frequency: Int.random(in: 0..<100),
                    title: "7인승",
                    price: CLNumber(0)),
              .init(id: .init(),
                   isSelected: false,
                    frequency: .random(in: 0..<100),
                    title: "8인승",
                    price: .init(280000)
                   )
             ],
              modelTypeDetailState: .init(content: .mock(), hmgData: .mock())
             ),
        .init(title: "구동방식",
             imageURL: nil,
              optionStates: [
                .init(id: .init(),
                      isSelected: true,
                      frequency: .random(in: 0..<100),
                      title: "2WD",
                      price: .init(0)
                     ),
                .init(id: .init(),
                      isSelected: false,
                      frequency: .random(in: 0..<100),
                      title: "4WD",
                      price: .init(237000)
                     )
              ],
              modelTypeDetailState: .init(content: .mock(), hmgData: nil)
             )
      ], fuelEfficiencyAverageState: .mock())
    }

    var modelTypeIntents: [ModelTypeModel.State]
    var fuelEfficiencyAverageState: FuelEfficiencyAverageBannerState
  }

  enum ViewAction: Equatable {
    case onAppear
    case calculateFuelEfficiency
  }

}
