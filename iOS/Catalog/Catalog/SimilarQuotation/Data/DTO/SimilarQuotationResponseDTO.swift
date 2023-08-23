//
//  SimilarQuotationResponse.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/21.
//

import Foundation

enum SimilarQuotationError :Error {
  case failedToDomain
}
struct SimilarQuotationResponseDTO: Decodable {
  var modelType: ModelTypeNameResponseDTO?
  var image: String?
  var price: Int?
  var options: [SimilarQuotationOptionResponseDTO]?
}

extension SimilarQuotationResponseDTO {
  func toDomain() throws -> SimilarQuotation {
    guard let typeNames = modelType else { throw SimilarQuotationError.failedToDomain }
    guard let similarPrice = price else { throw SimilarQuotationError.failedToDomain }
    guard let similarOptions = options else { throw SimilarQuotationError.failedToDomain }
    
    let typeNamesDomain = try typeNames.toDomain()
    return SimilarQuotation(powertrainName: typeNamesDomain[0] ,
                            bodytypeName: typeNamesDomain[1],
                            drivetrainName: typeNamesDomain[2],
                            price: CLNumber(Int32(similarPrice)),
                            options: similarOptions.compactMap({try? $0.toDomain()}))
  }
}

struct ModelTypeNameResponseDTO: Codable {
  var powertrainName: String?
  var bodytypeName: String?
  var drivetrainName: String?
}
extension ModelTypeNameResponseDTO {
  func toDomain() throws -> [String] {
    guard let powertrain = powertrainName else { throw SimilarQuotationError.failedToDomain }
    guard let bodytype = bodytypeName else { throw SimilarQuotationError.failedToDomain }
    guard let drivetrain = drivetrainName else { throw SimilarQuotationError.failedToDomain }

    return [powertrain, bodytype, drivetrain]
  }
}
struct SimilarQuotationOptionResponseDTO: Decodable {
  var id: Int?
  var category: String?
  var name: String?
  var image: String?
  var price: Int?
}

extension SimilarQuotationOptionResponseDTO {
  func toDomain() throws -> SimilarQuotationOption {
    guard let optionId = id else { throw SimilarQuotationError.failedToDomain }
    guard let optionName = name else { throw SimilarQuotationError.failedToDomain }
    guard let optionImage = image else { throw SimilarQuotationError.failedToDomain }
    guard let optionPrice = price else { throw SimilarQuotationError.failedToDomain }
    
    return SimilarQuotationOption(id: optionId,
                                  name: optionName,
                                  image: URL(string: optionImage),
                                  price: CLNumber(Int32(optionPrice)))
  }
}


