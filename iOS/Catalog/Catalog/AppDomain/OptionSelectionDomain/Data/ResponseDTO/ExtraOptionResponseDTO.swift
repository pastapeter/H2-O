//
//  ExtraOptionDTO.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/15.
//

import Foundation

enum ExtraOptionToDomainError: LocalizedError {
  case noIdInResponse
  case noNameInResponse
  case noPriceInResponse
}


struct ExtraOptionResponseDTO: Codable {
  
  var id: Int?
  var isPackage: Bool?
  var category: String?
  var name: String?
  var hashTags: [String]?
  var containsHmgData: Bool?
  var choiceRatio: Int?
  var price: Int?
  var image: String?
  
}

extension ExtraOptionResponseDTO {
  
  func toDomain() throws -> ExtraOption {
    
    guard let id = id else { throw ExtraOptionToDomainError.noIdInResponse }
    guard let name = name else { throw ExtraOptionToDomainError.noNameInResponse }
    guard let price = price else { throw ExtraOptionToDomainError.noPriceInResponse }
    
    var optionCategory = OptionCategory.total
    
    if let categoryStr = category {
      optionCategory = OptionCategory(categoryStr) ?? .total
    }
    
    var choiceRatioDomain: CLNumber?
    if let choiceRatio = choiceRatio {
      choiceRatioDomain = CLNumber(Int32(choiceRatio))
    }
    
    var optionImageURL: URL?
    
    if let optionImageURLStr = image {
      optionImageURL = URL(string: optionImageURLStr)
    }
    
    return ExtraOption(id: id,
                       isPackage: isPackage ?? false,
                       category: optionCategory,
                       name: name,
                       hashTags: hashTags ?? [],
                       containsHmgData: containsHmgData ?? false,
                       choiceRatio: choiceRatioDomain,
                       price: CLNumber(Int32(price)),
                       image: optionImageURL
      )
    
    
  }
}
