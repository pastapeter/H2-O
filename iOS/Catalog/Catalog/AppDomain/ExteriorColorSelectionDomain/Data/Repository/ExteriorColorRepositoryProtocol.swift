//
//  ExternalColorRepositoryProtocol.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import Foundation

protocol ExteriorColorRepositoryProtocol {

  func fetch(with trimId: Int) async throws -> [ExteriorColor]
  
//  func fetch(with urls: [URL]) async throws -> [Data]

}
