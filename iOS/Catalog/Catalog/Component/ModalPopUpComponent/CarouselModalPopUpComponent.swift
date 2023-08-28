//
//  ModalPopUpComponent.swift
//  Catalog
//
//  Created by Jung peter on 8/11/23.
//

import SwiftUI


struct CarouselModalPopUpComponent<ModalPopUpContent: View, Item: ModalItemable>: View {

  var modalContentItems: [Item]
  var selectedId: Int
  var submitAction: (Int) -> Void

  @Environment (\.dismiss)
  private var dismiss

  @State private var animateView: Bool = false

  @State private var animateContent: Bool = false

  @ViewBuilder var content: (Item) -> ModalPopUpContent
  @State var currentIndexBinding: Int = 0

}


extension CarouselModalPopUpComponent {

  var body: some View {
    VStack {
      if animateView {
        VStack(alignment: .center) {
          Spacer().frame(height: CGFloat(48).scaledHeight)
          SnapCarousel(items: modalContentItems, spacing: 16, trailingSpace: 32, index: $currentIndexBinding, borderStyle: .none) { state in
            GeometryReader { proxy in
              let size = proxy.size
              contentView(state: state)
                .cornerRadius(4, corners: .allCorners)
                .frame(width: size.width, height: CGFloat(487).scaledHeight)
                .background(.blue)
            }
          }
          .onChange(of: currentIndexBinding) { _ in
          }
          .frame(height: CGFloat(487).scaledHeight)
          
        }
        Spacer().frame(height: CGFloat(48).scaledHeight)
        HStack(spacing: 10) {
          ForEach(modalContentItems.indices, id: \.self) { index in
            Capsule()
              .fill(currentIndexBinding == index ? Color.primary0 : Color.gray200)
              .frame(width: (currentIndexBinding == index ? 24 : 8), height: 8)
              .scaleEffect((currentIndexBinding == index) ? 1.4 : 1)
              .animation(.spring(), value: currentIndexBinding == index)
          }
        }
      }

    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(content: {
      DimmedZStack { }
        .edgesIgnoringSafeArea(.all)
        .opacity(animateContent ? 0.8 : 0)
    })
    .onAppear {
      withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.8)) {
        animateView = true
        animateContent = true
      }
    }
  }

}

extension CarouselModalPopUpComponent {
  
  
  @ViewBuilder
  func contentView(state: Item) -> some View {
    
    var isSelectedBinding: Binding<Bool> {
      .init(get: { isInactive(state: state)},
            set: { _ in })
    }
    
    VStack {
      titleView(state.title)
        .padding(.horizontal, 16)
      content(state)
      CLInActiceButton(
        mainText: "선택하기",
        isEnabled: isSelectedBinding,
        subText: state.price.signedWon,
        inActiveText: "선택완료",
        height: CGFloat(87).scaledHeight,
        buttonAction: {
          if let id = state.id as? Int {
            submitAction(id)
          }
        }
      )
      .frame(height: CGFloat(56).scaledHeight)
    }
    .background(.white)
    
  }
  
  @ViewBuilder
  func titleView(_ text: String) -> some View {
    ZStack(alignment: .center) {
      Text(text)
        .catalogFont(type: .HeadKRMedium18)
        .foregroundColor(.gray900)
      HStack {
        Spacer()
        Button {
          withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.8)) {
            dismiss()
            animateView = false
            animateContent = false
          }
        } label: {
          Image("cancel")
        }
      }
    }
    .frame(height: CGFloat(60).scaledHeight)
  }
  
  private func isInactive(state: Item) -> Bool {
    guard let id = state.id as? Int else { return false }
    return id != selectedId
  }
}
