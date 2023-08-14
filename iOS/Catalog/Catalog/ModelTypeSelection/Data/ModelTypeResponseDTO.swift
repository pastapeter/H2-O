//
//  ModelTypeResponseDTO.swift
//  Catalog
//
//  Created by Jung peter on 8/14/23.
//

import Foundation

// Powertrain
struct PowertrainDTO: Codable {
    let id: Int?
    let name: String?
    let price: Int?
    let choiceRatio: Int?
    let description: String?
    let image: String?
    let maxOutput: MaxOutputDTO?
    let maxTorque: MaxTorqueDTO?
}

struct MaxOutputDTO: Codable {
    let output: Double?
    let minRpm: Int?
    let maxRpm: Int?
}

struct MaxTorqueDTO: Codable {
    let torque: Double
    let minRpm: Int
    let maxRpm: Int
}

// Bodytype
struct BodyTypeDTO: Codable {
    let id: Int?
    let name: String?
    let price: Int?
    let choiceRatio: Int?
    let description: String?
    let image: String?
}

// Drivetrain
struct DrivetrainDTO: Codable {
    let id: Int?
    let name: String?
    let price: Int?
    let choiceRatio: Int?
    let description: String?
    let image: String?
}

// Root
struct ModelTypeResponseDTO: Codable {
    let powertrains: [PowertrainDTO]?
    let bodytypes: [BodyTypeDTO]?
    let drivetrains: [DrivetrainDTO]?

}
