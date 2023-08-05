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
          CLNavigationView.build(intent: CLNavigationIndent(initialState: .init(currentPage: 0)))
        }
    }
}
