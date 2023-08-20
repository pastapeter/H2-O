//
//  ContentView.swift
//  Catalog
//
//  Created by Jung peter on 8/1/23.
//

import SwiftUI

struct EntryPointView: View {
  @State var showPopUp: Bool = true
  var body: some View {
      ZStack {
        VStack(spacing: 0) {
          CLNavigationView.build(intent: CLNavigationIntent(initialState: .init(currentPage: 0, showQuotationSummarySheet: false)))
        }
        if showPopUp {
          EntryGuide(showEntryGuide: $showPopUp)
        }
      }
      .ignoresSafeArea()
    
  }
}

struct TrimSelectionView_Previews: PreviewProvider {
    static var previews: some View {
      EntryPointView()
    }
}
