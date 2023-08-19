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
  
  func toDomain() -> MaxOutputFromEngine? {
    
    guard let output = output, let minRpm = minRpm, let maxRpm = maxRpm else { return nil}

    return MaxOutputFromEngine(output: output, minRPM: minRpm, maxRPM: maxRpm)
  }
  
}
