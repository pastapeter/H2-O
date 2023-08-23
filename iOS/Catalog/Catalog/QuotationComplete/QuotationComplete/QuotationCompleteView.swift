//
//  QuotationCompleteView.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/17.
//

import SwiftUI
import UIKit

struct QuotationCompleteView: IntentBindingType {

  @StateObject var container: Container<QuotationCompleteIntentType, QuotationCompleteModel.State>

  var intent: QuotationCompleteIntentType {
    container.intent
  }

  var state: QuotationCompleteModel.State {
    intent.state
  }
  
  @SwiftUI.State var isExternal: Bool = true
  @SwiftUI.State var showSheet: Bool = false

}

extension QuotationCompleteView: View {
  var body: some View {
    VStack {
      ZStack {
        if isExternal {
          QuotationExteriorView()
        } else {
          QuotationInteriorView()
        }
        VStack {
          Spacer()
          CLToggle(isLeft: $isExternal)
            .padding(.vertical, 8)
        }
      }
      QuotationSheetTop()
        .gesture(
          DragGesture()
            .onChanged { gesture in
              if gesture.translation.height < 20 {
                showSheet = true
              }
            }
        )

    }
    .sheet(isPresented: $showSheet) {
      QuotationCompleteSheet(state: state,
                             modelName: intent.quotationService.getModelName(),
                             intent: intent)
    }
    .onAppear {
      intent.send(action: .onAppear)
    }
  }
}

extension QuotationCompleteView {

  @ViewBuilder
  static func build(intent: QuotationCompleteIntent) -> some View {
    QuotationCompleteView(container: .init(intent: intent,
                                                    state: intent.state,
                                                    modelChangePublisher: intent.objectWillChange))
  }
}
