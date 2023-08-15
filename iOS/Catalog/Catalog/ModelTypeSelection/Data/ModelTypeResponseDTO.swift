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
extension PowertrainDTO {
  func toOptionInDetail() throws -> OptionInDetail {
    return OptionInDetail(title: name ?? "",
                   choiceRatio: choiceRatio ?? 0,
                   price: CLNumber(Int32(price ?? 0)),
                   description: description ?? "",
                   imageURL: URL(string: image ?? ""),
                   maxOuputFromEngine: try maxOutput?.toDomain(),
                   maxTorqueFromEngine: try maxTorque?.toDomain())
  }
}

struct MaxOutputDTO: Codable {
    let output: Double?
    let minRpm: Int?
    let maxRpm: Int?
}
extension MaxOutputDTO {
  func toDomain() throws -> MaxOutputFromEngine {
    return MaxOutputFromEngine(output: output ?? 0,
                               minRPM: minRpm ?? 0,
                               maxRPM: maxRpm ?? 0)
  }
}

struct MaxTorqueDTO: Codable {
    let torque: Double?
    let minRpm: Int?
    let maxRpm: Int?
}
extension MaxTorqueDTO {
  func toDomain() throws -> MaxTorqueFromEngine {
    return MaxTorqueFromEngine(torque: torque ?? 0,
                               minRPM: minRpm ?? 0,
                               maxRPM: maxRpm ?? 0)
  }
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
extension BodyTypeDTO {
  func toDomain() throws -> Option {
    return Option(id: id ?? 0,
                  title: name ?? "",
                  choiceRatio: choiceRatio ?? 0,
                  price: CLNumber(Int32(price ?? 0)),
                  imageURL: URL(string: image ?? ""))
  }
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
extension DrivetrainDTO {
  func toDomain() throws -> Option {
    return Option(id: id ?? 0,
                  title: name ?? "",
                  choiceRatio: choiceRatio ?? 0,
                  price: CLNumber(Int32(price ?? 0)),
                  imageURL: URL(string: image ?? ""))
  }
}

// Root
struct ModelTypeResponseDTO: Codable {
    let powertrains: [PowertrainDTO]?
    let bodytypes: [BodyTypeDTO]?
    let drivetrains: [DrivetrainDTO]?
}
