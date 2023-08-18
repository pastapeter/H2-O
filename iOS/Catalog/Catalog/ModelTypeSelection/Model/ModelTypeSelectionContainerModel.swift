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
      return .init(
        selectedTrimId: 1,
        modelTypeStateArray: [
          .init(modelTypeDetailState: [.init(content: .mock(), hmgData: .mock()),
                                       .init(content: .mock(), hmgData: .mock())]),
          .init(title: "바디타입", imageURL: nil,
                optionStates: [
                  .init(id: 0,
                        isSelected: true,
                        frequency: Int.random(in: 0..<100),
                        title: "7인승",
                        price: CLNumber(0)),
                  .init(id: 1,
                        isSelected: false,
                        frequency: .random(in: 0..<100),
                        title: "8인승",
                        price: .init(280000))
                ],
              modelTypeDetailState: [.init(content: .mock(), hmgData: .mock()),
                                     .init(content: .mock(), hmgData: .mock())]),

            .init(title: "구동방식", imageURL: nil,
                  optionStates: [
                    .init(id: 2,
                          isSelected: true,
                          frequency: .random(in: 0..<100),
                          title: "2WD",
                          price: .init(0)),
                    .init(id: 3,
                          isSelected: false,
                          frequency: .random(in: 0..<100),
                          title: "4WD",
                          price: .init(237000))
                  ],
                  modelTypeDetailState: [.init(content: .mock(), hmgData: nil)]
            )
        ], fuelEfficiencyAverageState: .mock())
    }

    var selectedTrimId: Int = 1
    var modelTypeStateArray: [ModelTypeModel.State]
    var fuelEfficiencyAverageState: FuelEfficiencyAverageBannerState
  }

  enum ViewAction {
    case onAppear
    case modelTypeOptions(options: [ModelTypeOption])
    case calculateFuelEfficiency
  }

}
