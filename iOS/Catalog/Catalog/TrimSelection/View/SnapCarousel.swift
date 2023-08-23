//
//  TrimScrollView.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/12.
//

import SwiftUI

struct SnapCarousel<Content: View, T: Identifiable>: View {
  
  enum BorderStyle {
    case `default`
    case none
  }

  var content: (T) -> Content
  var items: [T]

  var spacing: CGFloat
  var trailingSpace: CGFloat
  var borderStyle: BorderStyle

  @Binding var index: Int

  init(items: [T],
       spacing: CGFloat = 16,
       trailingSpace: CGFloat,
       index: Binding<Int>,
       borderStyle: BorderStyle = .default,
       @ViewBuilder content: @escaping (T) -> Content) {

    self.items = items
    self.spacing = spacing
    self.trailingSpace = trailingSpace
    self._index = index
    self.borderStyle = borderStyle
    self.content = content
  }

  @GestureState var offset: CGFloat = 0
  @State var currentIndex: Int = 0
}

extension SnapCarousel {

  var body: some View {

    GeometryReader { proxy in

      // setting correct width for snap Carousel
      let width = proxy.size.width - trailingSpace - spacing
      let adjustmentWidth = 0
      HStack(spacing: spacing) {

        ForEach(items.indices, id: \.self) { itemIndex in
          switch borderStyle {
          
          case .`default`:
            content(items[itemIndex])
              .frame(width: proxy.size.width - 2 * trailingSpace)
              .border(index == itemIndex ? Color.skyBlue : Color.gray200)
          case .none:
            content(items[itemIndex])
              .frame(width: proxy.size.width - 2 * trailingSpace)
          }
            
        }
      }
      .padding(.horizontal, spacing)
      .offset(x: spacing + (CGFloat(currentIndex) * -width) + CGFloat((adjustmentWidth)) + offset)
      .gesture(
        DragGesture()
          .updating($offset) { value, state, _ in
            state = value.translation.width
          }
          .onEnded { value in
              // update current index
            let offsetX = value.translation.width
            let progress = -offsetX / width
            let roundIndex = progress.rounded()
            currentIndex = max(min(currentIndex + Int(roundIndex), items.count - 1), 0)
            currentIndex = index
          }

          .onChanged { value in
            let offsetX = value.translation.width
            let progress = -offsetX / width
            let roundIndex = progress.rounded()
            index = max(min(currentIndex + Int(roundIndex), items.count - 1), 0)
          }
      )
    }
    .animation(.easeInOut, value: offset == 0)
  }
}
