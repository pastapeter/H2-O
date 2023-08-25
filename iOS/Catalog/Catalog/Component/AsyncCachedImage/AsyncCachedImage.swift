//
//  AsyncCachedImage.swift
//  Catalog
//
//  Created by Jung peter on 8/23/23.
//

import SwiftUI

struct AsyncCachedImage<Content: View, Placeholder: View, Fail: View>: View {
  
  enum AsyncCachedImageError: Error {
    case invalidData
  }
  
  enum Status {
    case idle
    case loading
    case failed(Error)
    case loaded(Image)
  }
  
  @ViewBuilder
  let content: (Image) -> Content
  
  @ViewBuilder
  let placeholder: (() -> Placeholder)?
  
  @ViewBuilder
  let fail: ((Error) -> Fail)?
  
  private var imageCacher = ImageCacheService.shared
  var imageURL: URL?
  @State private var status: Status = .idle
  

  init(
    url: URL?,
    content: @escaping (Image) -> Content,
    placeholder: (() -> Placeholder)?,
    fail: ((Error) -> Fail)?
  ) {
    
    self.imageURL = url
    self.content = content
    self.placeholder = placeholder
    self.fail = fail
    
    if let imageURL = self.imageURL {
      startLoading(url: imageURL)
    }
    
  }
  
    var body: some View {
      Group {
        imageView
      }
      .onAppear {
        if case Status.idle = status, let imageURL {
          startLoading(url: imageURL)
        }
      }
      .onChange(of: imageURL) { url in
        guard let url else {
          status = .idle
          return
        }
        startLoading(url: url)
      }
    }
  
  @ViewBuilder
  var imageView: some View {
      switch status {
      case .idle:
        LoadingComponent()
      case .loading:
          if let placeholder {
              placeholder()
          } else {
            LoadingComponent()
          }
      case .failed(let error):
          LoadingComponent()
      case .loaded(let image):
          content(image)
      }
  }
  
  func startLoading(url: URL) {
    
    status = .loading
    Task {
      do {
        for try await imageData in imageCacher.setImageByStream(url) {
          if let image = Image(data: imageData) {
            status = .loaded(image)
          } else {
            status = .failed(AsyncCachedImageError.invalidData)
          }
        }
      } catch {
        status = .failed(error)
      }
      
    }
  }
  
}

extension AsyncCachedImage {
  
  init(
      url: URL?,
      content: @escaping (Image) -> Content,
      fail: @escaping (Error) -> Fail
  ) where Placeholder == EmptyView {
      self.imageURL = url
      self.content = content
      self.placeholder = nil
      self.fail = fail
      self.status = status
  }
  
  init(
      url: URL?,
      content: @escaping (Image) -> Content
  ) where Placeholder == EmptyView , Fail == EmptyView {
      self.imageURL = url
      self.content = content
      self.placeholder = nil
      self.fail = nil
      self.status = status
  }

  init(
      url: URL?,
      content: @escaping (Image) -> Content,
      placeholder: @escaping () -> Placeholder,
      fail: @escaping (Error) -> Fail
  ) where Placeholder == EmptyView {
      self.imageURL = url
      self.content = content
      self.placeholder = placeholder
      self.fail = fail
      self.status = status
  }
  
  init(
      url: URL?,
      content: @escaping (Image) -> Content,
      placeholder: @escaping () -> Placeholder
  ) where Fail == EmptyView {
      self.imageURL = url
      self.content = content
      self.placeholder = placeholder
      self.fail = nil
      self.status = status
  }

}
