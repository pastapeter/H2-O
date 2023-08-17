//
//  Color +.swift
//  Catalog
//
//  Created by Jung peter on 8/1/23.
//

import SwiftUI

extension Color {

  static let activeBlue = Color("ActiveBlue")
  static let activeBlue2 = Color("ActiveBlue2")
  static let skyBlue = Color("SkyBlue")

  static let blueBG = Color("BlueBG")
  static let cardBG = Color("CardBG")
  static let skyBlueCardBG = Color("SkyBlueCardBG")

  static let gray50 = Color("Gray50")
  static let gray100 = Color("Gray100")
  static let gray200 = Color("Gray200")
  static let gray300 = Color("Gray300")
  static let gray400 = Color("Gray400")
  static let gray500 = Color("Gray500")
  static let gray600 = Color("Gray600")
  static let gray700 = Color("Gray700")
  static let gray800 = Color("Gray800")
  static let gray900 = Color("Gray900")

  static let primary0 = Color("PrimaryColor0")
  static let primary100 = Color("PrimaryColor100")
  static let primary200 = Color("PrimaryColor200")
  static let primary300 = Color("PrimaryColor300")
  static let primary400 = Color("PrimaryColor400")
  static let primary500 = Color("PrimaryColor500")
  static let primary600 = Color("PrimaryColor600")
  static let primary700 = Color("PrimaryColor700")
  static let primary800 = Color("PrimaryColor800")
  static let primary900 = Color("PrimaryColor900")

  static let sand = Color("Sand")
  static let sand2 = Color("Sand2")
  static let lightSand = Color("LightSand")

  static let background2 = Color("background2")
  static let imageTagBackground = Color("ImageTagBackground")
}

extension Color {

  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")

    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)

    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >> 8) & 0xFF) / 255.0
    let b = Double((rgb >> 0) & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b)
  }

}
