//
//  OptionCardScollView.swift
//  Catalog
//
//  Created by Jung peter on 8/16/23.
//

import SwiftUI

struct OptionCardScollView: IntentBindingType {
  
  @StateObject var container: Container<OptionCardScrollIntentType, OptionCardScrollModel.State>
  
  var intent: OptionCardScrollIntentType {
    container.intent
  }
  
  var viewState: OptionCardScrollModel.State {
    intent.viewState
  }
  
}

extension OptionCardScollView: View {
  
  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      FilterButtonBar(state: viewState.filterState, intent: intent)
        .padding(.horizontal, 16)
      List(viewState.cardStates, id: \.self) { cardState in
        OptionCardView.build(intent: .init(initialState: cardState, parent: intent, repository: intent.repository))
      }
      .listStyle(.plain)
    }
    .onAppear {
      intent.send(action: .onAppear)
    }
  }
  
}

extension OptionCardScollView {
  
  @ViewBuilder
  static func build(intent: OptionCardScrollIntent) -> some View {
    
    OptionCardScollView(container: .init(intent: intent,
                                                state: intent.viewState,
                                                modelChangePublisher: intent.objectWillChange)
                              )
  }
  
}

