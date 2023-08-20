//
//  OptionSelectRepositoryProtocol.swift
//  Catalog
//
//  Created by Jung peter on 8/18/23.
//

import Foundation

protocol OptionSelectionRepositoryProtocol {
  
  func fetchExtraOption(from startIndex: Int, to lastIndex: Int) async throws -> [ExtraOption]
  
  func fetchDefaultOption(from startIndex: Int, to lastIndex: Int) async throws -> [DefaultOption]
  
  func fetchDetailInfo(of optionID: Int) async throws -> DetailOptionInfo
  
  func fetchPackageInfo(of packageID: Int) async throws -> PackageInfo
  
  func fetchAllDefaultOptions() async throws -> [DefaultOption]
  
  func fetchAllExtraOptions() async throws -> [ExtraOption]
  
}
