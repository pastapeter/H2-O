//
//  DriveTrainDTO.swift
//  Catalog
//
//  Created by Jung peter on 8/19/23.
//

import Foundation

struct DriveTrainDTO: Codable {
    let id: Int?
    let name: String?
    let price: Int?
    let choiceRatio: Int?
    let description: String?
    let image: String?
}

extension DriveTrainDTO: ModelTypeDomainConvertable {
  
  func toDomain() throws -> ModelTypeOption {
    
    guard let id = id else { throw ModelTypeToDomainError.noIdInResponse(from: .DriveTrain) }
    guard let name = name else { throw ModelTypeToDomainError.noNameInResponse(from: .DriveTrain) }
    guard let price = price else { throw ModelTypeToDomainError.noPriceInResponse(from: .DriveTrain) }
    
    
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
                           imageURL: imageURL)
    
  }
  
  func toDomain() throws -> DriveTrainModel {
    return DriveTrainModel(
                           id: id ?? 0,
                           name: name ?? "",
                           price: CLNumber(Int32(price ?? 0)),
                           choiceRaatio: choiceRatio ?? 0,
                           description: description ?? "",
                           image: URL(string: image ?? ""))
  }
}
