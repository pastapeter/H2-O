//
//  ModelType.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/09.
//

import Foundation

struct ModelType {
    private var powerTrain: Powertrain?
}

enum Powertrain {
    case diesel
    case gasoline
}

enum BodyType {
    case seven
    case eight
}

enum DrivingMethod {
    case twoWheel
    case fourWheel
}
