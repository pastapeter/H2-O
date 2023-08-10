//
//  CLPrice.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/06.
//

import Foundation

struct CLPrice: Comparable {

    static func < (lhs: CLPrice, rhs: CLPrice) -> Bool {
        return lhs.price < rhs.price
    }

    var price: Int32 = 0

    init(_ price: Int32) {
        guard price >= 0 else { print("금액이 0원 미만입니다."); return }
        self.price = price
    }
}

extension CLPrice {
    func numberFormatter(number: Int32) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: number)) ?? ""
    }
}

extension CLPrice: CustomStringConvertible {
    var description: String {
        return numberFormatter(number: price) + "원"
    }

    var spacingDescription: String {
        return numberFormatter(number: price) + " 원"
    }

    var sliderDescription: String {
        return String(price).dropLast(4) + "만원"
    }

    var signedDescription: String {
        return (price >= 0 ? "+" : "-") + self.description
    }
}
