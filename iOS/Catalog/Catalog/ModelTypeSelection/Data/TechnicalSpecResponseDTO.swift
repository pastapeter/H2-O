//
//  FuelAndDisplacementRequestDTO.swift
//  Catalog
//
//  Created by Jung peter on 8/19/23.
//

import Foundation

enum TechnicalSpceResponseToDomainError: Error {
  case noDisplacementInResponse
  case noFuelEfficiencyInResponse
}

struct TechnicalSpecResponseDTO: Codable {
  
  var displacement: Int?
  var fuelEfficiency: Double?
  
}

extension TechnicalSpecResponseDTO {
  
  func toDomain() throws -> ResultOfCalculationOfFuelAndDisplacement {
    
    guard let displacement = displacement else { throw TechnicalSpceResponseToDomainError.noDisplacementInResponse }
    guard let fuelEfficiency = fuelEfficiency else { throw TechnicalSpceResponseToDomainError.noFuelEfficiencyInResponse }
    
    return ResultOfCalculationOfFuelAndDisplacement(displacement: CLNumber(Int32(displacement)) , fuelEfficiency: fuelEfficiency )
  }
  
}
