//
//  ImageCacheService.swift
//  Catalog
//
//  Created by Jung peter on 8/23/23.
//

import Foundation
import Combine

protocol CacheServiceProtocol {

  func setImage(_ url: URL) async throws -> Data
  
}

class ImageCacheService: CacheServiceProtocol {
  
  static let shared = ImageCacheService()
  private var imageMemoryCache = ImageMemoryCache()
  private var diskCache: DiskCache!
  private init() { }
  
  private lazy var cachePath: String = {
      let basePath = DiskCache.basePath()
      let cachePath = (basePath as NSString).appendingPathComponent("image")
      return cachePath
  }()
  
  private func formatPath(withFormatName formatName: String) -> String {
      let formatPath = (cachePath as NSString).appendingPathComponent(formatName)
      do {
          try FileManager.default.createDirectory(atPath: formatPath, withIntermediateDirectories: true, attributes: nil)
      } catch {
          print("\(formatPath)를 가진 폴더를 만드는데 실패")
      }
      return formatPath
  }
  
  func configureCache(with maximumMemoryBytes: Int, with maximumDiskBytes: Int) {
    Task {
      await imageMemoryCache.configureCachePolicy(with: maximumMemoryBytes)
    }
    diskCache = DiskCache(path: formatPath(withFormatName: "image"), size: 0, capacity: UInt64(maximumDiskBytes))
  }
  
  func setImage(_ url: URL) async throws -> Data {
    
    //1. NSCache 먼저 확인하기
    if let image = await self.checkMemoryCache(url) {
      Log.debug(message: "메모리캐시에 있음")
      return image.imageData
      /*
       do {
         // 서버에 이미지가 바뀌었는지 확인하고
         return try await getImage(with: url, etag: image.etag).imageData
       } catch {
         // 바뀌지 않았으면 내려보내
         return image.imageData
       }
       */
    }
    
    //2. DiskCache 확인하기
    if let image = await self.checkDiskCache(url) {
      Log.debug(message: "디스크캐시에 있음")
      return image.imageData
      /*
       do {
         return try await getImage(with: url, etag: image.etag).imageData
       } catch {
         return image.imageData
       }
       */
    }
    
    //3. Network Request
    return try await self.getImage(with: url).imageData
  }
  
}

// MARK: - Fetching
extension ImageCacheService {
  
  private func getImage(with url: URL, etag: String? = nil) async throws -> CacheImage {
    
    var imageRequest = URLRequest(url: url)
    
    if let etag = etag {
      imageRequest.addValue(etag, forHTTPHeaderField: "If-None-Match")
    }

    //TODO: 이미지 URLRequest
    do {
      let (data, response) = try await URLSession(configuration: .ephemeral).makeData(for: imageRequest)
      guard let httpResponse = response as? HTTPURLResponse else { throw CLNetworkError.invalidURL }
      switch httpResponse.statusCode {
      case (200...299):
        let etag = httpResponse.allHeaderFields["Etag"] as? String ?? ""
        let image = CacheImage(imageData: data, etag: etag)
        await self.saveIntoMemoryCache(with: url, image: image)
        self.saveIntoDiskCache(imageURL: url, image: image)
        return image
      case 304:
        throw ImageCacheError.imageNotModified
      default:
        throw ImageCacheError.networkError(reason: .invalidServerResponse(reason: httpResponse.statusCode))
      }
    } catch(let e) {
      throw CLNetworkError.URLError(message: e.localizedDescription)
    }
    
  }
  
}

// MARK: - About Memory Cache
extension ImageCacheService {
  
  private func saveIntoMemoryCache(with imageURL: URL, image: CacheImage) async {
    await self.imageMemoryCache.save(data: CacheImageObject(cacheImage: image), with: imageURL.path)
  }
  
  private func checkMemoryCache(_ imageURL: URL) async -> CacheImage? {
    guard let cached = await self.imageMemoryCache.read(with: imageURL.path) else { return nil }
    self.diskCache.updateDiskAccessDate(by: imageURL.path)
    return cached
  }
  
}

// MARK: - About Disk Cache
extension ImageCacheService {
  
  private func saveIntoDiskCache(imageURL: URL, image: CacheImage) {
    
    do {
      let data = try JSONEncoder().encode(image)
      self.diskCache.saveIntoCache(data: data, key: imageURL.path)
    } catch {
      Log.error(message: ImageCacheError.notAvailableDecoding.localizedDescription, error: error)
    }

  }
  
  private func checkDiskCache(_ imageURL: URL) async -> CacheImage? {
    
    do {
      let imageData = try await self.diskCache.fetchData(by: imageURL.path)
      let cacheImage: CacheImage = try JSONDecoder().decode(CacheImage.self, from: imageData)
      await self.saveIntoMemoryCache(with: imageURL, image: cacheImage)
      return cacheImage
    } catch {
      Log.error(message: ImageCacheError.notAvailableToFetchFromDiskCache.localizedDescription, error: error)
     return nil
    }
    
  }
  
}
