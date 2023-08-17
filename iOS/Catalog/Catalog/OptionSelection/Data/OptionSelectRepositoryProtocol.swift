//
//  OptionSelectRepositoryProtocol.swift
//  Catalog
//
//  Created by Jung peter on 8/18/23.
//

import Foundation

protocol OptionSelectionRepositoryProtocol {
  
  func fetchExtraOption(from startIndex: Int, to lastIndex: Int) -> [OptionDTO]
  
  func fetchDefaultOption(from startIndex: Int, to lastIndex: Int) -> [OptionDTO]
  
  func fetchDetailInfo(of optionID: Int, in trimID: Int) -> [OptionDTO]
  
  func fetchPackageInfo(of packageID: Int, in trimID: Int) -> PackageResponseDTO
  
}
