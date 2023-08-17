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
  var externalColor: ExternalColorDTO?
  var internalColor: InternalColorDTO?
}

extension TrimDefaultOptionDTO {
  func toDomain(trim: Trim) throws -> CarQuotation {

    // TODO: - 에러처리
    CarQuotation(trim: trim,
                 powertrain: try powertrain!.toDomain(),
                 bodytype: try bodytype!.toDomain(),
                 drivetrain: try drivetrain!.toDomain(),
                 externalColor: try externalColor!.toDomain(),
                 internalColor: try internalColor!.toDomain(),
                 options: []
    )
  }
}
