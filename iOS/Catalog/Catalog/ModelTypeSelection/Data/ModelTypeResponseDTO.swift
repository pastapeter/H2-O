//
//  ModelTypeResponseDTO.swift
//  Catalog
//
//  Created by Jung peter on 8/14/23.
//

import Foundation

// Root
struct ModelTypeResponseDTO: Codable {
    let powertrains: [PowerTrainDTO]?
    let bodytypes: [BodyTypeDTO]?
    let drivetrains: [DriveTrainDTO]?
}
