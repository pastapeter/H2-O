//
//  TrimDefaultOptionDTO.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/16.
//

import Foundation

struct TrimDefaultOptionDTO: Decodable {
  var powertrain: PowerTrainDTO?
  var bodytype: BodyTypeDTO?
  var drivetrain: DriveTrainDTO?
  var externalColor: ExteriorColorResponseDTO?
  var internalColor: InteriorColorResponseDTO?
}

extension TrimDefaultOptionDTO {
  func toDomain(trim: Trim) throws -> CarQuotation {
    guard let pt = powertrain else { throw TrimSelectionError.FailedToDomain }
    guard let bt = bodytype else { throw TrimSelectionError.FailedToDomain }
    guard let dt = drivetrain else { throw TrimSelectionError.FailedToDomain }
    guard let ec = externalColor else { throw TrimSelectionError.FailedToDomain }
    guard let ic = internalColor else { throw TrimSelectionError.FailedToDomain }

    return CarQuotation(trim: trim,
                        powertrain: try pt.toDomain(),
                        bodytype: try bt.toDomain(),
                        drivetrain: try dt.toDomain(),
                        externalColor: try ec.toDomain(),
                        internalColor: try ic.toDomain(),
                        options: []
    )
  }
}
