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
  @Binding var imageURL: URL?
  @State private var status: Status = .idle
  

  init(
    url: URL?,
    content: @escaping (Image) -> Content,
    placeholder: (() -> Placeholder)?,
    fail: ((Error) -> Fail)?
  ) {
    
    self._imageURL = .constant(url)
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
        LoadingView(title: "기다려주세요")
      case .loading:
          if let placeholder {
              placeholder()
          } else {
            LoadingView(title: "기다려주세요")
          }
      case .failed(let error):
        LoadingView(title: "기다려주세요")
      case .loaded(let image):
          content(image)
      }
  }
  
  func startLoading(url: URL) {
    
    status = .loading
    Task {
      do {
        let imageData = try await imageCacher.setImage(url)
        if let image = Image(data: imageData) {
          status = .loaded(image)
          //1
          //downSampling -> 큰 사진을 내 화면 비율에 똑맞춰서 보여주기 -> size받아와서 그 size 에 맞춰서 사진 스케일링을 해
        } else {
          status = .failed(AsyncCachedImageError.invalidData)
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
      self._imageURL = .constant(url)
      self.content = content
      self.placeholder = nil
      self.fail = fail
      self.status = status
  }
  
  init(
      url: URL?,
      content: @escaping (Image) -> Content
  ) where Placeholder == EmptyView , Fail == EmptyView {
      self._imageURL = .constant(url)
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
      self._imageURL = .constant(url)
      self.content = content
      self.placeholder = placeholder
      self.fail = fail
      self.status = status
  }

}
