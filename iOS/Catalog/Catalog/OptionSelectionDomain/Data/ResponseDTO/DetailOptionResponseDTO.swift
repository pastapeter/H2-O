//
//  DetailOptionResponseDTO.swift
//  Catalog
//
//  Created by Jung peter on 8/18/23.
//

import Foundation

enum DetailOptionToDomainError: Error {
  

  case noNameInResponse
  case noPriceInResponse
  
}

struct HmgDataResponseDTO: Codable {
    let choiceCount: Int?
    let isOverHalf: Bool?
    let useCount: Int?
}

extension HmgDataResponseDTO {
  func toDomain() -> DetailOptionInfo.HMGData? {
    if isOverHalf == nil && choiceCount == nil && useCount == nil {
      return nil
    }
    
    var choiceCountDomain : CLNumber?
    if let choiceCount = choiceCount {
      choiceCountDomain = CLNumber(Int32(choiceCount))
    }
    
    var useCountDomain : CLNumber?
    if let useCount = useCount {
      choiceCountDomain = CLNumber(Int32(useCount))
    }
    
    return .init(isOverHalf: isOverHalf, choiceCount: choiceCountDomain, useCount: useCountDomain)
  }
}

struct DetailOptionResponseDTO: Codable {
    let category: String?
    let containsChoiceCount: Bool?
    let containsUseCount: Bool?
    let description: String?
    let hashTags: [String]?
    let hmgData: HmgDataResponseDTO?
    let image: String?
    let name: String?
    let price: Int?
}

extension DetailOptionResponseDTO {
  
  func toDomain(with optionID: Int) throws -> DetailOptionInfo {
    
    guard let name = name else { throw DetailOptionToDomainError.noNameInResponse }
    guard let price = price else { throw DetailOptionToDomainError.noNameInResponse }
    
    var optionCategory: OptionCategory = .total
    if let category = category {
      optionCategory = OptionCategory(category) ?? .total
    }
    
    var imageURL: URL?
    if let imageURLstr = image {
      imageURL = URL(string: imageURLstr)
    }
    
    
    return DetailOptionInfo(id: optionID, category: optionCategory,
                            containsChoiceCount: containsChoiceCount ?? false,
                            containsUseCount: containsUseCount ?? false,
                            description: description,
                            hashTags: hashTags ?? [],
                            hmgData: hmgData?.toDomain(),
                            image: imageURL,
                            title: name,
                            price: CLNumber(Int32(price)))
    
  }
  
  
}



