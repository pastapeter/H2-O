//
//  OptionSelectionRepository.swift
//  Catalog
//
//  Created by Jung peter on 8/18/23.
//

import Foundation

final class OptionSelectionRepository: OptionSelectionRepositoryProtocol {
  
  private var requestManager: RequestManagerProtocol
  private var trimID: Int
  
  init(requestManager: RequestManagerProtocol, trimID: Int) {
    self.requestManager = requestManager
    self.trimID = trimID
  }
  
  func fetchAllDefaultOptions() async throws -> [DefaultOption] {
    
    let dto: [DefaultOptionResponseDTO] = try await requestManager.perform(OptionSelectionRequest.fetchAllDefaultOption(trimID: trimID))
    
    let entity = dto.compactMap {
      do {
      return try $0.toDomain()
      } catch(let e) {
        print("🚨 Error \(e.localizedDescription)")
        return nil
      }
    }
    
    return entity
  }
  
  func fetchAllExtraOptions() async throws -> [ExtraOption] {
    let dto: [ExtraOptionResponseDTO] = try await requestManager.perform(
      OptionSelectionRequest.fetchAllExtraOption(trimID: trimID))
    
    let entity = dto.compactMap { do {
      return try $0.toDomain()
    } catch(let e) {
      print("🚨 Error \(e.localizedDescription)")
      return nil
    }}
    
    return entity
    
  }
  
  func fetchExtraOption(from startIndex: Int, to lastIndex: Int) async throws -> [ExtraOption] {
    
    let dto: [ExtraOptionResponseDTO] = try await requestManager.perform(
      OptionSelectionRequest.fetchExtraOption(trimID: trimID, from: startIndex, to: lastIndex))
    
    let entity = dto.compactMap { do {
      return try $0.toDomain()
    } catch(let e) {
      print("🚨 Error \(e.localizedDescription)")
      return nil
    }}
    
    return entity
  }
  
  func fetchDefaultOption(from startIndex: Int, to lastIndex: Int) async throws -> [DefaultOption] {
    
    let dto: [DefaultOptionResponseDTO] = try await requestManager.perform(
      OptionSelectionRequest.fetchDefaultOption(trimID: trimID, from: startIndex, to: lastIndex)
    )
    
    return dto.compactMap {
      do {
        return try $0.toDomain()
      } catch(let e) {
        print("🚨 Error \(e.localizedDescription)")
        return nil
      }
    }
    
  }
  
  func fetchDetailInfo(of optionID: Int) async throws -> DetailOptionInfo {
    
    let dto: DetailOptionResponseDTO = try await requestManager.perform(
      OptionSelectionRequest.fetchDetailOf(trimID: trimID, optionID: optionID)
    )
    
    return try dto.toDomain()
    
  }
  
  func fetchPackageInfo(of packageID: Int) async throws -> PackageInfo {
    
    let dto: PackageResponseDTO = try await requestManager.perform(
      OptionSelectionRequest.fetchPackage(trimID: trimID, packageID: packageID)
    )
    
    return try dto.toDomain()
    
  }
  
  
  
}
