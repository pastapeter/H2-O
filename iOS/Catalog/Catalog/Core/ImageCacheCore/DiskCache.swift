//
//  DiskCache.swift
//  Catalog
//
//  Created by Jung peter on 8/22/23.
//

import Foundation
import SwiftUI

struct CartaLogCacheConstant {
  static let domain = "h2-cartalog"
}

class DiskCache {
  
  static func basePath() -> String {
    
    let cachesPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    let pathComponent = CartaLogCacheConstant.domain
    let basePath = (cachesPath as NSString).appendingPathComponent(pathComponent)
    return basePath
    
  }
  
  let path: String
  
  var size: UInt64 = 0
  
  var capacity: UInt64 = 0 {
    didSet {
      self.cacheSerialQueue.async {
        self.controlCapacity()
      }
    }
  }
  
  lazy var cacheSerialQueue: DispatchQueue = {
    let queueName = CartaLogCacheConstant.domain + "." + (self.path as NSString).lastPathComponent
    return DispatchQueue(label: queueName)
  }()
  
  init(path: String, size: UInt64, capacity: UInt64) {
    self.path = path
    self.size = size
    self.capacity = capacity
    self.cacheSerialQueue.async {
      self.calculateSize()
      self.controlCapacity()
    }
  }
  
  func saveIntoCache(data: Data?, key: String) {
    cacheSerialQueue.async {
      if let data = data {
        self.saveIntoCache(data, key: key)
      } else {
        Log.error(message: DiskCacheError.notAvailableOfFetchingData(key: key).localizedDescription)
      }
    }
  }
  
  
  /// DiskCache에서 데이터 가져오기
  /// - Parameter key: hash값
  func fetchData(by key: String) async throws -> Data {
    let path = self.path(forKey: key)
    do {
      let data = try Data(contentsOf: URL(fileURLWithPath: path), options: Data.ReadingOptions())
      self.updateDiskAccessDate(by: key)
      return data
    } catch {
      Log.error(message: DiskCacheError.notAvailableOfFetchingData(path: path).localizedDescription, error: error)
      throw error
    }
  }
  
  
  func removeData(with etag: String) {
    self.removeFile(atPath: self.path(forKey: etag))
  }
  
  func removeAllData() {
    let fileManager = FileManager.default
    let cachePath = self.path
    cacheSerialQueue.async {
      do {
        let contents = try fileManager.contentsOfDirectory(atPath: cachePath)
        for pathComponent in contents {
          let path = (cachePath as NSString).appendingPathComponent(pathComponent)
          do {
            try fileManager.removeItem(atPath: path)
          } catch {
            Log.error(message: DiskCacheError.notAvailableToDeleteFile(path: path).localizedDescription, error: error)
          }
        }
        self.calculateSize()
      } catch {
        Log.error(message: DiskCacheError.notAvailableToFindFile(path: self.path).localizedDescription)
      }
    }
  }
  
  func path(forKey key: String) -> String {
    let fileName = key.filter { $0.isLetter }
    let keyPath = (self.path as NSString).appendingPathComponent("\(fileName)")
    return keyPath
  }
  
}

// MARK: - Private method
extension DiskCache {
  
  private func saveIntoCache(_ data: Data, key: String) {
    let path = self.path(forKey: key)
    
    let fileManager = FileManager.default
    let previousAttributes : [FileAttributeKey: Any]? = try? fileManager.attributesOfItem(atPath: path)
    
    do {
      try data.write(to: URL(fileURLWithPath: path), options: Data.WritingOptions.atomicWrite)
    } catch {
      Log.error(message: DiskCacheError.notAvailableOfWritingDataWith(key: key, path: path).localizedDescription, error: error)
    }
    
    //만약 해당 키값에 매핑되는 file path에 데이터가 있다면 sync를 해줘야함
    if let attributes = previousAttributes {
      // file size를 확인하고
      if let fileSize = attributes[FileAttributeKey.size] as? UInt64 {
        // 기존꺼를 빼
        substract(size: fileSize)
      }
    }
    // 최신꺼를 더해
    self.size += UInt64(data.count)
    self.controlCapacity()
  }
  
  @discardableResult
  /// LRU 기반 캐시에서 데이터 엑세스시 AccessDate 변경해주기
  func updateDiskAccessDate(by key: String) -> Bool {
    let path = self.path(forKey: key)
    let fileManager = FileManager.default
    let now = Date()
    do {
      try fileManager.setAttributes([FileAttributeKey.modificationDate : now], ofItemAtPath: path)
      return true
    } catch {
      Log.error(message: DiskCacheError.notAvailabletoUpdateDate.localizedDescription, error: error)
      return false
    }
  }
  
  // 현재 캐시사이즈 구하기
  private func calculateSize() {
    let fileManager = FileManager.default
    let cachePath = self.path
    do {
      // 캐시 폴더 내부 하위 폴더들
      let contents = try fileManager.contentsOfDirectory(atPath: cachePath)
      for pathComponent in contents {
        let path = (cachePath as NSString).appendingPathComponent(pathComponent)
        do {
          let attributes: [FileAttributeKey: Any] = try fileManager.attributesOfItem(atPath: path)
          if let filesize = attributes[FileAttributeKey.size] as? UInt64 {
            size += filesize
          }
        } catch {
          Log.error(message: DiskCacheError.notAvailableToLoadFileAttributes.localizedDescription, error: error)
        }
      }
    } catch {
      Log.error(message: DiskCacheError.notAvailableToLoadFolderInSubDirectory.localizedDescription, error: error)
    }
  }
  
  /// 캐시용량
  /// 만약 캐시크기가 정해진 욜량보다 작거나 같으면 조절할 필요가없음
  /// 만약에 크다면, LRU 기반으로 동작하게한다.
  private func controlCapacity() {
    
    if self.size <= self.capacity { return }
    
    let fileManager = FileManager.default
    let cachePath = self.path
    
    let sortedURL = fileManager.enumerateContentsOfDirectory(atPath: cachePath, ascending: true)
    
    for url in sortedURL {
      if self.size <= self.capacity { break }
      self.removeFile(atPath: url.path)
    }
    
  }
  
  private func removeFile(atPath path: String) {
    let fileManager = FileManager.default
    do {
      let attributes: [FileAttributeKey: Any] = try fileManager.attributesOfItem(atPath: path)
      do {
        try fileManager.removeItem(atPath: path)
        if let fileSize = attributes[FileAttributeKey.size] as? UInt64 {
          substract(size: fileSize)
        }
      } catch {
        Log.error(message: DiskCacheError.notAvailableToDeleteFile(path: path).localizedDescription, error: error)
      }
    } catch {
      Log.error(message: DiskCacheError.notAvailableToFindFile(path: path).localizedDescription, error: error)
    }
  }
  
  private func substract(size: UInt64) {
    if self.size >= size {
      self.size -= size
    } else {
      self.size = 0
    }
  }
  
  
  
}

