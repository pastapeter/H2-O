//
//  BodyTypeDTO.swift
//  Catalog
//
//  Created by Jung peter on 8/19/23.
//

import Foundation

struct BodyTypeDTO: Codable {
    let id: Int?
    let name: String?
    let price: Int?
    let choiceRatio: Int?
    let description: String?
    let image: String?
}

extension BodyTypeDTO: ModelTypeDomainConvertable {
  
  func toDomain() throws -> ModelTypeOption {
    
    guard let id = id else { throw ModelTypeToDomainError.noIdInResponse(from: .BodyType) }
    guard let name = name else { throw ModelTypeToDomainError.noNameInResponse(from: .BodyType) }
    guard let price = price else { throw ModelTypeToDomainError.noPriceInResponse(from: .BodyType) }
    
    
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
  
  func toDomain() throws -> BodyTypeModel {
    return BodyTypeModel(
                           id: id ?? 0,
                           name: name ?? "",
                           price: CLNumber(Int32(price ?? 0)),
                           choiceRaatio: choiceRatio ?? 0,
                           description: description ?? "",
                           image: URL(string: image ?? ""))
  }
}
