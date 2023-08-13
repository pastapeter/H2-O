//
//  Trim.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/09.
//

import Foundation

struct Trim {
    private var name: String
    private var description: String
    private var price: CLNumber // 시작 가격

    private var externalImage: [URL] // 360도 회전 고민중
    private var internalImage: URL
}
