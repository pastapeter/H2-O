//
//  ModelTypeModels.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/15.
//

import Foundation

protocol ModelTypeProtocol: Hashable {
  var id: Int { get set }
  var name: String { get set }
  var price: CLNumber { get set }
  var choiceRaatio: Int { get set }
  var description: String { get set }
  var image: URL? { get set }
}

struct PowerTrainModel: ModelTypeProtocol {
  var id: Int
  var name: String
  var price: CLNumber
  var choiceRaatio: Int
  var description: String
  var image: URL?
  var maxOutput: MaxOutputFromEngine?
  var maxTorque: MaxTorqueFromEngine?
}

struct BodyTypeModel: ModelTypeProtocol {
  var id: Int
  var name: String
  var price: CLNumber
  var choiceRaatio: Int
  var description: String
  var image: URL?
}

struct DriveTrainModel: ModelTypeProtocol {
  var id: Int
  var name: String
  var price: CLNumber
  var choiceRaatio: Int
  var description: String
  var image: URL?
}
