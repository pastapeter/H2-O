//
//  NSItemProvider.swift
//  Catalog
//
//  Created by Jung peter on 8/22/23.
//

import UIKit
import SwiftUI
import UniformTypeIdentifiers

extension NSItemProvider {
  
  enum NSItemProviderLoadImageError: Error {
    case unexpectedImagetype
  }
  
  func loadImage(completion: @escaping (UIImage?, Error?) -> Void) {
    
    if canLoadObject(ofClass: UIImage.self) {
      
      loadObject(ofClass: UIImage.self) { image, error in
        guard let resultImage = image as? UIImage else {
          completion(nil, error)
          return
        }
        
        completion(resultImage, error)
      }
      
    } else if hasItemConformingToTypeIdentifier(UTType.webP.identifier) {
      loadDataRepresentation(forTypeIdentifier: UTType.webP.identifier) { data, error in
        guard let data, let webpImage = UIImage(data: data) else {
            completion(nil, error)
          return
          }
        completion(webpImage, error)
      }
    } else {
      completion(nil, NSItemProviderLoadImageError.unexpectedImagetype)
    }
  }
  
}
