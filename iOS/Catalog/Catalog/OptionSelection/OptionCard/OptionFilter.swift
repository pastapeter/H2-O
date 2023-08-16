//
//  OptionFilter.swift
//  Catalog
//
//  Created by Jung peter on 8/16/23.
//

import Foundation

struct OptionFilter {

  enum AdditionalOptionFilter: CustomStringConvertible, CaseIterable {
    case total
    case detail
    case accessory
    case wheel

    var description: String {
      switch self {
      case .total:
        return "전체"
      case .detail:
        return "상세종목"
      case .accessory:
        return "악세서리"
      case .wheel:
        return "휠"
      }
    }
  }

  enum DefaultOptionFilter: CustomStringConvertible, CaseIterable {
    case total
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
  }

}
