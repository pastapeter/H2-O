//
//  ContentView.swift
//  Catalog
//
//  Created by Jung peter on 8/1/23.
//

import SwiftUI

struct EntryPointView: View {
    @State var showPopUp: Bool = true
    @State var showQuotationSummarySheet: Bool = false
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
              CLNavigationView.build(intent: CLNavigationIntent(initialState: .init(currentPage: 0)))
            }
            .sheet(isPresented: $showQuotationSummarySheet) {
              CLQuotationSummarySheet(quotation: CarQuotation.mockQuotation(),
                                      showQuotationSummarySheet: $showQuotationSummarySheet)
            }
            .padding(.bottom, 0.1)
            if showPopUp {
              EntryGuide(showEntryGuide: $showPopUp)
            }
        }
    }
}

struct TrimSelectionView_Previews: PreviewProvider {
    static var previews: some View {
      EntryPointView()
    }
}
