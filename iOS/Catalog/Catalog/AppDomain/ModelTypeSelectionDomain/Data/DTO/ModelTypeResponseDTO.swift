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

extension ModelTypeResponseDTO {
  
  func toDomain() -> [ModelType] {
      
    var result: [ModelType] = []
    
    if let powerTrainModelType = modelTypeDTOToModeType(with: "파워트레인", dtos: powertrains) {
      result.append(powerTrainModelType)
    }
    
    if let bodytypeModelType = modelTypeDTOToModeType(with: "바디타입", dtos: bodytypes) {
      result.append(bodytypeModelType)
    }
    
    if let driveTrainModelType = modelTypeDTOToModeType(with: "구동방식", dtos: drivetrains) {
      result.append(driveTrainModelType)
    }
    
    return result
  }
  
  
  private func modelTypeDTOToModeType<DTO: ModelTypeDomainConvertable>(with title: String, dtos: [DTO]?) -> ModelType? {
    
    if let dtos = dtos {
      
      var modelTypeOptions: [ModelTypeOption] = []
      for dto in dtos {
        do {
          let modelTypeOption: ModelTypeOption = try dto.toDomain()
          modelTypeOptions.append(modelTypeOption)
        } catch(let e) {
          Log.debug(message: "🚨 \(e.localizedDescription)")
          continue
        }
      }
      
      if modelTypeOptions.count == 2 {
        return ModelType(title: title, options: modelTypeOptions)
      }
      
    }
    
    return nil
  }
  
}
