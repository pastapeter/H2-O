//
//  DefaultOptionDTO.swift
//  Catalog
//
//  Created by Jung peter on 8/18/23.
//

import Foundation

enum DefaultOptionToDomainError: LocalizedError {
  case noIdInResponse
  case noNameInResponse
}


struct DefaultOptionResponseDTO: Codable {
  
  var category: String?
  var containsHMGData: Bool?
  var hashTags: [String]?
  var id: Int?
  var image: String?
  var name: String?
  
}

extension DefaultOptionResponseDTO {
  
  func toDomain() throws -> DefaultOption {
    
    guard let id = id else { throw DefaultOptionToDomainError.noIdInResponse }
    
    guard let name = name else { throw DefaultOptionToDomainError.noNameInResponse }
    
    var optionCategory = OptionCategory.total
    
    var optionImageURL: URL?
    
    if let optionImageURLStr = image {
      optionImageURL = URL(string: optionImageURLStr)
    }
    
    if let categoryStr = category {
      optionCategory = OptionCategory(categoryStr) ?? .total
    }
    
    return DefaultOption(id: id,
                         name: name,
                         image: optionImageURL,
                         containsHmgData: containsHMGData ?? false,
                         hashTags: hashTags ?? [],
                         category: optionCategory)
    
  }
}
