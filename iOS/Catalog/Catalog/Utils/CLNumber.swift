//
//  CLNumber.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/06.
//

import Foundation

struct CLNumber: Comparable, Hashable, Codable {

  var value: Int32 = 0

  init(_ price: Int32) {
    self.value = price
  }
}

extension CLNumber {
  func numberFormatter(number: Int32) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    return numberFormatter.string(from: NSNumber(value: number)) ?? ""
  }
}

extension CLNumber: CustomStringConvertible {

  var description: String {
    return numberFormatter(number: value)
  }

  var won: String {
    return numberFormatter(number: value) + "원"
  }

  var wonWithSpacing: String {
    return numberFormatter(number: value) + " 원"
  }

  var conversionWonToTenThousandWon: String {
    return String(value).dropLast(4) + "만원"
  }

  var signedWon: String {
    return (value >= 0 ? "+" : "") + self.won
  }
}

extension CLNumber {
  static func < (lhs: CLNumber, rhs: CLNumber) -> Bool {
    return lhs.value < rhs.value
  }

  static func + (lhs: CLNumber, rhs: CLNumber) -> CLNumber {
    return CLNumber(lhs.value + rhs.value)
  }
  
  static func - (lhs: CLNumber, rhs: CLNumber) -> CLNumber {
    return CLNumber(lhs.value - rhs.value)
  }

  static func / (lhs: CLNumber, rhs: CLNumber) -> CLNumber {
    return CLNumber(lhs.value / rhs.value)
  }
}
