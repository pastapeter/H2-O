//
//  ExternalColorRepositoryProtocol.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import Foundation

protocol ExternalColorRepositoryProtocol {

  func fetch(with trimId: Int) async throws -> [ExternalColor]

}
