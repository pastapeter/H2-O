//
//  CLOption.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/09.
//

import Foundation

struct Option {
    var name: String
    var category: Category
    var image: URL
    var price: CLNumber
    var hashTags: [HashTag]
    var containsHmgData: Bool
}
