//
//  CacheError.swift
//  Catalog
//
//  Created by Jung peter on 8/24/23.
//

import Foundation

enum ImageCacheError: LocalizedError {
  case imageNotModified
  case notAvailableDecoding
  case notAvailableToFetchFromDiskCache
  case networkError(reason: CLNetworkError)
  case fileManagerError(reason: FileManagerError)
}

extension ImageCacheError {
  
  var localizedDescription: String? {
    switch self {
    case .imageNotModified:
      return "304 - 이미지는 그대로입니다."
    case .notAvailableDecoding:
      return "DecodingError입니다."
    case .notAvailableToFetchFromDiskCache:
      return "디스크캐시로부터 데이터를 불러올 수 없습니다."
    case .networkError(let reason):
      return "네트워크 애러 \(reason)"
    case .fileManagerError(let reason):
      return "파일메니저 애러 \(reason)"
    }
  }
  
}

enum DiskCacheError: LocalizedError {
  case notAvailableOfFetchingData(key: String)
  case notAvailableOfFetchingData(path: String)
  case notAvailableOfWritingDataWith(key: String, path: String)
  case notAvailabletoUpdateDate
  case notAvailableToLoadFolderInSubDirectory
  case notAvailableToLoadFileAttributes
  case notAvailableToDeleteFile(path: String)
  case notAvailableToFindFile(path: String)
  
}

extension DiskCacheError {
  var localizedDescription: String? {
    switch self {
    case .notAvailableOfFetchingData(let key):
      return "\(key)값을 가진 data를 받아올 수 없습니다."
    case .notAvailableOfFetchingData(let path):
      return "\(path)에서 data를 받아올 수 없습니다."
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
  case notAvailableOfFetchContentByProperties
}

extension FileManagerError {
  var localizedDescription: String? {
    switch self {
    case .notAvailableOfCreatingFolder:
      return "폴더 생성에 오류가 생겼습니다."
    case .notAvailableOfFetchContentByProperties:
      return "폴더 내부 content를 프로퍼티를 통해 가져오는 것에 오류가 발생하였습니다."
    }
  }
}
