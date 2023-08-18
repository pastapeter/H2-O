//
//  PackageInfoDTO.swift
//  Catalog
//
//  Created by Jung peter on 8/18/23.
//

import Foundation

enum PackageInfoToDomainError: LocalizedError {
  case noComponentNameInResponse
  case noComponentPriceInResponse
  case noPackageNameInResponse
  case noPackagePriceInResponse
  
}

struct PackageComponentResponseDTO: Codable {
    let name: String?
    let category: String?
    let image: String?
    let description: String?
    let hashTags: [String]?
    let useCount: Int?
    let price: Int?
    let containsHmgData: Bool?
}

extension PackageComponentResponseDTO {
  func toDomain() throws -> PackageComponent {
    
    guard let name = name else { throw PackageInfoToDomainError.noComponentNameInResponse }
    guard let price = price else { throw PackageInfoToDomainError.noComponentPriceInResponse }
    
    var imageURL: URL?
    if let imageURLstr = image {
      imageURL = URL(string: imageURLstr)
    }
    
    return .init(name: name,
                 category: OptionCategory(category ?? "전체") ?? .total,
                 image: imageURL,
                 description: description,
                 hashTags: hashTags ?? [],
                 useCount: useCount,
                 price: price,
                 containsHmgData: containsHmgData ?? false)
    
  }
}


struct PackageResponseDTO: Codable {
    let name: String?
    let category: String?
    let price: Int?
    let choiceRatio: Int?
    let choiceCount: Int?
    let isOverHalf: Bool?
    let hashTags: [String]?
    let components: [PackageComponentResponseDTO]?
}

extension PackageResponseDTO {
  
  func toDomain() throws -> PackageInfo {
    
    guard let name = name else { throw PackageInfoToDomainError.noPackageNameInResponse }
    guard let price = price else { throw PackageInfoToDomainError.noPackagePriceInResponse }
    
    return .init(name: name,
                 price: price,
                 choiceRatio: choiceRatio,
                 choiceCount: choiceCount,
                 isOverHalf: isOverHalf,
                 hashTags: hashTags ?? [],
                 components: components?.compactMap{
                  do { return try $0.toDomain() }
                  catch(let e) {
                    print("🚨 Error \(e)")
                    return nil }
                  } ?? [])
  
  }
  
}



