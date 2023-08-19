//
//  MaxOutputDTO.swift
//  Catalog
//
//  Created by Jung peter on 8/19/23.
//

import Foundation

struct MaxOutputDTO: Codable {
    let output: Double?
    let minRpm: Int?
    let maxRpm: Int?
}

extension MaxOutputDTO {
  
  func toDomain() -> MaxOutputFromEngine {

    return MaxOutputFromEngine(output: output, minRPM: minRpm, maxRPM: maxRpm)
  }
  
}
