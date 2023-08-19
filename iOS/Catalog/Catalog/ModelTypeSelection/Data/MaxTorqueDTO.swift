//
//  MaxTorqueDTO.swift
//  Catalog
//
//  Created by Jung peter on 8/19/23.
//

import Foundation

struct MaxTorqueDTO: Codable {
    let torque: Double?
    let minRpm: Int?
    let maxRpm: Int?
}

extension MaxTorqueDTO {
  func toDomain() throws -> MaxTorqueFromEngine {
    return MaxTorqueFromEngine(torque: torque,
                               minRPM: minRpm,
                               maxRPM: maxRpm)
  }
}
