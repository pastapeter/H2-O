//
//  PowerTrainModel.swift
//  Catalog
//
//  Created by Jung peter on 8/19/23.
//

import Foundation

struct PowerTrainModel: Equatable {
  var id: Int
  var name: String
  var price: CLNumber
  var choiceRaatio: Int
  var description: String
  var image: URL?
  var maxOutput: MaxOutputFromEngine?
  var maxTorque: MaxTorqueFromEngine?
}
