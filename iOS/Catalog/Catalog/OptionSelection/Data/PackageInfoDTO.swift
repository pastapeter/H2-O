//
//  PackageInfoDTO.swift
//  Catalog
//
//  Created by Jung peter on 8/18/23.
//

import Foundation

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
