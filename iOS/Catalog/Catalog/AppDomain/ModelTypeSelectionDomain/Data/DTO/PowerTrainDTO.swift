//
//  PowerTrainDTO.swift
//  Catalog
//
//  Created by Jung peter on 8/19/23.
//

import Foundation

protocol ModelTypeDomainConvertable {
  func toDomain() throws -> ModelTypeOption
}

enum ModelTypeToDomainError: LocalizedError {
  case noIdInResponse(from: ModelTypeToDomainError.ModelType)
  case noNameInResponse(from: ModelTypeToDomainError.ModelType)
  case noPriceInResponse(from: ModelTypeToDomainError.ModelType)
  
  enum ModelType {
    case PowerTrain
    case BodyType
    case DriveTrain
  }
  
}

struct PowerTrainDTO: Codable, ModelTypeDomainConvertable {
  let id: Int?
  let name: String?
  let price: Int?
  let choiceRatio: Int?
  let description: String?
  let image: String?
  let maxOutput: MaxOutputDTO?
  let maxTorque: MaxTorqueDTO?
}


extension PowerTrainDTO {
  
  func toDomain() throws -> ModelTypeOption {
    
    guard let id = id else { throw ModelTypeToDomainError.noIdInResponse(from: .PowerTrain) }
    guard let name = name else { throw ModelTypeToDomainError.noNameInResponse(from: .PowerTrain) }
    guard let price = price else { throw ModelTypeToDomainError.noPriceInResponse(from: .PowerTrain) }
    
    
    var choiceRatioDomain: CLNumber?
    if let choiceRatio = choiceRatio {
      choiceRatioDomain = CLNumber(Int32(choiceRatio))
    }
    
    var imageURL: URL?
    if let imageURLstr = image {
      imageURL = URL(string: imageURLstr)
    }
    
    return ModelTypeOption(id: id,
                           name: name,
                           choiceRatio: choiceRatioDomain,
                           price: CLNumber(Int32(price)),
                           description: description,
                           thumbnailImageURL: nil,
                           imageURL: imageURL,
                           maxOuputFromEngine: maxOutput?.toDomain(),
                           maxTorqueFromEngine: maxTorque?.toDomain())
    
    
  }
  
  func toDomain() throws -> PowerTrainModel {
    return PowerTrainModel(
      id: id ?? 0,
      name: name ?? "",
      price: CLNumber(Int32(price ?? 0)),
      choiceRaatio: choiceRatio ?? 0,
      description: description ?? "",
      image: URL(string: image ?? ""),
      maxOutput: (maxOutput ?? MaxOutputDTO(output: 0, minRpm: 0, maxRpm: 0)).toDomain(),
      maxTorque: (maxTorque ?? MaxTorqueDTO(torque: 0, minRpm: 0, maxRpm: 0)).toDomain())
  }
}


