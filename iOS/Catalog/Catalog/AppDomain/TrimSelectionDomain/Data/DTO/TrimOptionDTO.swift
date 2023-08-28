//
//  TrimOptionDTO.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/16.
//

import Foundation

struct TrimOptionDTO: Decodable {
  var dataLabel: String?
  var frequency: Double? // TODO: - 서버에서 Int로 바꿔주면 변경
}

extension TrimOptionDTO {
  func toDomain() -> HMGDatum {
    return HMGDatum(optionTitle: dataLabel ?? "", optionFrequency: Int(frequency ?? 0))
  }
}

struct HMGDatum {
  var optionTitle: String
  var optionFrequency: Int
}
