//
//  ColorContentable.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import SwiftUI

protocol ColorContentable: View {

  var isSelected: Bool { get }

  var color: CarColorType { get }

  init(isSelected: Bool, color: CarColorType)

}
