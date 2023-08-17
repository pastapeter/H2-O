//
//  ModelTypeModels.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/15.
//

import Foundation

struct PowerTrainModel: Codable {
  var id: Int
  var name: String
  var price: CLNumber
  var choiceRaatio: Int
  var description: String
  var image: URL?
  var maxOutput: MaxOutputFromEngine
  var maxTorque: MaxTorqueFromEngine
}

struct BodyTypeModel: Codable {
  var id: Int
  var name: String
  var price: CLNumber
  var choiceRaatio: Int
  var description: String
  var image: URL?
}

struct DriveTrainModel: Codable {
  var id: Int
  var name: String
  var price: CLNumber
  var choiceRaatio: Int
  var description: String
  var image: URL?
}
