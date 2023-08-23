//
//  CacheError.swift
//  Catalog
//
//  Created by Jung peter on 8/24/23.
//

import Foundation

enum ImageCacheError: LocalizedError {
  case imageNotModified
  case networkError(reason: CLNetworkError)
  case fileManagerError(reason: FileManagerError)
}

enum DiskCacheError: LocalizedError {
  case notAvailableOfWritingDataWith(key: String, path: String)
  case notAvailabletoUpdateDate
  case notAvailableToLoadFolderInSubDirectory
  case notAvailableToLoadFileAttributes
  case notAvailableToDeleteFile(path: String)
  case notAvailableToFindFile(path: String)
  
}

extension DiskCacheError {
  var errorDescription: String? {
    switch self {
    
    case .notAvailableOfWritingDataWith(let key, let path):
      return "해당 키값\(key)을 가진 fileURL \(path)에 데이터 쓰기 실패했습니다."
    case .notAvailabletoUpdateDate:
      return "파일의 Date를 변경해줄수 없습니다."
    case .notAvailableToLoadFolderInSubDirectory:
      return "하위 디렉토리의 contents를 Load할 수 없습니다."
    case .notAvailableToLoadFileAttributes:
      return "파일Attribute를 Load할 수 없습니다"
    case .notAvailableToDeleteFile:
      return "파일을 삭제할 수 없습니다."
    case .notAvailableToFindFile:
      return "파일을 찾을 수 없습니다."
    }
  }
}

enum FileManagerError: LocalizedError {
  case notAvailableOfCreatingFolder
}
