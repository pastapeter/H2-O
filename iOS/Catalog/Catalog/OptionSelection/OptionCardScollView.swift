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
  
  var state: OptionCardScrollModel.State {
    intent.state
  }
  
}

extension OptionCardScollView: View {
  
  var body: some View {
    VStack {
      FilterButtonBar(state: state.filterState, intent: intent)
      ScrollView {
        VStack(spacing: 16) {
          
          OptionCardView(isSelected: true)
          OptionCardView()
          OptionCardView()
          OptionCardView()
          OptionCardView()
          OptionCardView()
          OptionCardView()
          OptionCardView()
          OptionCardView()
        }
      }
    }
    .padding(.horizontal, 16)
  }
  
}

extension OptionCardScollView {
  
  @ViewBuilder
  static func build(intent: OptionCardScrollIntent) -> some View {
    
    return OptionCardScollView(container: .init(intent: intent,
                                                state: intent.state,
                                                modelChangePublisher: intent.objectWillChange)
                              )
  }
  
}

struct OptionCardScollView_Previews: PreviewProvider {
  static var previews: some View {
    OptionCardScollView.build(intent: .init(initialState: .init(cardStates: [])))
  }
}
