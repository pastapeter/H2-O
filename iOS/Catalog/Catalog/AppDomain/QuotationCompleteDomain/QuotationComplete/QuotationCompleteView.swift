//
//  QuotationCompleteView.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/17.
//

import SwiftUI
import UIKit

struct QuotationCompleteView: IntentBindingType {

  @StateObject var container: Container<QuotationCompleteIntentType, QuotationCompleteModel.ViewState, QuotationCompleteModel.State>
  
  var intent: QuotationCompleteIntentType {  container.intent }
  var viewState: QuotationCompleteModel.ViewState { intent.viewState }
  var state: QuotationCompleteModel.State { intent.state }
  
  @SwiftUI.State var isExternal: Bool = true
}

extension QuotationCompleteView {
  var showSheetBinding: Binding<Bool> {
    .init(get: { viewState.showSheet },
          set: { bool in intent.send(action: .showSheetChanged(showSheet: bool)) } )
  }
}

extension QuotationCompleteView: View {
  var body: some View {
    VStack {
      ZStack {
        if isExternal {
          QuotationExteriorView(quotation: intent.quotation)
        } else {
          QuotationInteriorView(quotation: intent.quotation)
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
                showSheetBinding.wrappedValue = true
              }
            }
        )

    }
    .sheet(isPresented: showSheetBinding) {
      QuotationCompleteSheet(state: state,
                            viewState: viewState,
                             modelName: intent.quotation.modelName(),
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
                                           viewState: intent.viewState,
                                           state: intent.state,
                                                    modelChangePublisher: intent.objectWillChange))
  }
}
