//
//  JSONLoader.swift
//  Catalog
//
//  Created by Jung peter on 8/9/23.
//

import Foundation

struct JSONLoader {

  static func load(with fileName: String) -> Data? {

    let extensionType = "json"
    guard let fileLocation = Bundle.main.url(forResource: fileName, withExtension: extensionType) else { return nil }

    do {
      let data = try Data(contentsOf: fileLocation)
      return data
    } catch {
      return nil
    }

  }
}
