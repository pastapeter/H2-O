//
//  OptionSelectRepositoryProtocol.swift
//  Catalog
//
//  Created by Jung peter on 8/18/23.
//

import Foundation

protocol DefaultOptionSelectionRepositoryProtocol  {
  
  func fetchAllOptions() async throws -> [DefaultOption]
  
  func fetchOption(from startIndex: Int, to lastIndex: Int) async throws -> [DefaultOption]
  
}

protocol ExtraOptionSelectionRepositoryProtocol {
  
  func fetchOption(from startIndex: Int, to lastIndex: Int) async throws -> [ExtraOption]
  
  func fetchAllOptions() async throws -> [ExtraOption]
    
}

protocol OptionSelectionRepositoryProtocol: DefaultOptionSelectionRepositoryProtocol, ExtraOptionSelectionRepositoryProtocol {
  
  func fetchDetailInfo(of optionID: Int) async throws -> DetailOptionInfo
  
  func fetchPackageInfo(of packageID: Int) async throws -> PackageInfo
  
}
