//
//  CatalogApp.swift
//  Catalog
//
//  Created by Jung peter on 8/1/23.
//

import SwiftUI

@main
struct CatalogApp: App {
    var body: some Scene {
        WindowGroup {
          ZStack {
             EntryPointView()
            .onAppear {
              var imagecache = ImageCacheService.shared
              imagecache.configureCache(with: CacheConstants.maximumMemoryCacheSize, with: CacheConstants.maximumDiskCacheSize)
            }
            //LoadingView(title: "데이터를 불러오는 중입니다.")
          }
        }
    }
}
