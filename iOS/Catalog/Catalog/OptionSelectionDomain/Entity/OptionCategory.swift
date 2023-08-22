//
//  OptionFilter.swift
//  Catalog
//
//  Created by Jung peter on 8/16/23.
//

import Foundation

enum OptionCategory: CustomStringConvertible {

  case total
  case detail
  case accessory
  case wheel
  case powerTrain
  case AISafeguardTech
  case safe
  case exterior
  case interior
  case seat
  case comfort
  case multimedia

  var description: String {
    switch self {
    case .total:
      return "전체"
    case .detail:
      return "상세종목"
    case .accessory:
      return "악세사리"
    case .wheel:
      return "휠"
    case .powerTrain:
      return "파워트레인/성능"
    case .AISafeguardTech:
      return "지능형 안전기술"
    case .safe:
      return "안전"
    case .exterior:
      return "외관"
    case .interior:
      return "내관"
    case .seat:
      return "시트"
    case .comfort:
      return "편의"
    case .multimedia:
      return "멀티미디어"
    }
  }

  static var additionalOptionFilter: [OptionCategory] {
    return [.total, .detail, .accessory, .wheel]
  }

  static var defaultOptionFilter: [OptionCategory] {
    return [.total, .powerTrain, .AISafeguardTech, .safe, .exterior, .interior, .seat, .comfort, .multimedia]
  }
  
}

extension OptionCategory {
  
  init?(_ korean: String) {
    
      var koreaDict : [String: Self] = [
        "파워트레인/성능" : .powerTrain,
        "지능형 안전기술" : .AISafeguardTech,
        "안전" : .safe,
        "외관" : .exterior,
        "내장" : .interior,
        "시트" : .seat,
        "편의" : .comfort,
        "멀티미디어" : .multimedia,
        "상세품목" : .detail,
        "악세사리" : .accessory,
        "휠" : .wheel,
      ]
    
    if let category = koreaDict[korean] {
      self = category
    } else {
        return nil
    }

  }
}
