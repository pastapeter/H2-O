//
//  CarColorContent.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import Foundation

enum CarColorType: Equatable {

  case interior(fabricImageURL: URL?)

  case exterior(hexColor: String)

}
