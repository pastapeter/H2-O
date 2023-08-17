//
//  TrimSelectView.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/11.
//

import SwiftUI

struct TrimSelectionView: IntentBindingType {
  @StateObject var container: Container<TrimSelectionIntentType, TrimSelectionModel.State>
  var intent: TrimSelectionIntentType { container.intent }
  var state: TrimSelectionModel.State { intent.state }
  @SwiftUI.State var currentIndexBinding: Int = 0

}

extension TrimSelectionView: View {
  var body: some View {
    VStack {
      HStack {
        Text("트림을 선택해주세요.")
          .catalogFont(type: .HeadKRMedium18)
        Spacer()
      }
      .padding(.leading, 20)
      .padding(.top, 20)

      SnapCarousel(items: state.trims,
                   spacing: 16,
                   trailingSpace: 32,
                   index: $currentIndexBinding) { trim in
        GeometryReader { proxy in
          let size = proxy.size
          TrimCardView(trim: trim)
            .frame(width: size.width, height: size.height)
        }
      }
     .onChange(of: currentIndexBinding) { _ in
       intent.send(action: .trimSelected(index: currentIndexBinding))
     }

      Spacer().frame(height: 15)

      // Indicator
      HStack(spacing: 10) {
        ForEach(state.trims.indices, id: \.self) { index in
          Capsule()
            .fill(currentIndexBinding == index ? Color.primary0 : Color.gray200)
            .frame(width: (currentIndexBinding == index ? 24 : 8), height: 8)
            .scaleEffect((currentIndexBinding == index) ? 1.4 : 1)
            .animation(.spring(), value: currentIndexBinding == index)
        }
      }
      .padding(.bottom, 20)

      CLButton(mainText: "\(state.selectedTrim?.name ?? "") 선택하기",
               height: 60,
               backgroundColor: Color.primary700,
               buttonAction: { intent.send(action: .onTapTrimSelectButton) })
      Spacer().frame(height: 0.1)
    }
    .onAppear(perform: { intent.send(action: .enteredTrimPage) })
  }
}

extension TrimSelectionView {
  @ViewBuilder
  static func build(intent: TrimSelectionIntent) -> some View {

    TrimSelectionView(container: .init(
      intent: intent as TrimSelectionIntent,
      state: intent.state,
      modelChangePublisher: intent.objectWillChange))
  }
}
