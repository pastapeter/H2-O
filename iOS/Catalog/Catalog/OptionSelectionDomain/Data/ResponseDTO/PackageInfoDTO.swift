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
    let containsHmgData: Bool?
}

extension PackageComponentResponseDTO {
  func toDomain() throws -> PackageComponent {
    
    guard let name = name else { throw PackageInfoToDomainError.noComponentNameInResponse }
    
    var imageURL: URL?
    if let imageURLstr = image {
      imageURL = URL(string: imageURLstr)
    }
    
    var useCountCLNumber: CLNumber?
    if let useCount = useCount {
      useCountCLNumber = CLNumber(Int32(useCount))
    }
    
    return .init(name: name,
                 category: OptionCategory(category ?? "전체") ?? .total,
                 image: imageURL,
                 description: description,
                 hashTags: hashTags ?? [],
                 useCount: useCountCLNumber,
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
  
  func toDomain(with packageID: Int) throws -> PackageInfo {
    
    guard let name = name else { throw PackageInfoToDomainError.noPackageNameInResponse }
    guard let price = price else { throw PackageInfoToDomainError.noPackagePriceInResponse }
    
    var choiceRatioCLNumber: CLNumber?
    var choiceCountCLNumber: CLNumber?
    
    if let choiceRatio = choiceRatio {
      choiceRatioCLNumber = CLNumber(Int32(choiceRatio))
    }
    
    if let choiceCount = choiceCount {
      choiceCountCLNumber = CLNumber(Int32(choiceCount))
    }
    
    return .init(id: packageID,
                  title: name,
                 price: CLNumber(Int32(price)),
                 choiceRatio: choiceRatioCLNumber,
                 choiceCount: choiceCountCLNumber,
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



