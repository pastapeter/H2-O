//
//  ExpandableText.swift
//  Catalog
//
//  Created by Jung peter on 8/22/23.
//

import SwiftUI

struct ExpandableText: View {
  var text : String
  
  var font: UIFont = CatalogTextType.TextKRRegular12.font
  var lineLimit: Int = 3
  var foregroundColor: Color = .primary
  
  var expandButton: TextSet = TextSet(text: "더보기", font: .TextKRRegular12, color: .gray600)
  
  var animation: Animation? = .none
  
  @State private var expand : Bool = false
  @State private var truncated : Bool = false
  @State private var fullSize: CGFloat = 0
  @Binding private var isFold: Bool
  
  init(text: String, isFold: Binding<Bool>) {
    self.text = text
    self._isFold = isFold
  }
  
  var body: some View {
    ZStack(alignment: .bottomTrailing){
      Group {
        Text(text)
      }
      .font(Font(font))
      .foregroundColor(foregroundColor)
      .lineLimit(expand == true ? nil : lineLimit)
      .animation(animation, value: expand)
      .mask(
        VStack(spacing: 0){
          Rectangle()
            .foregroundColor(.black)
          
          HStack(spacing: 0){
            Rectangle()
              .foregroundColor(.black)
            if truncated{
              if !expand {
                HStack(alignment: .bottom,spacing: 0){
                  LinearGradient(
                    gradient: Gradient(stops: [
                      Gradient.Stop(color: .black, location: 0),
                      Gradient.Stop(color: .clear, location: 0.8)]),
                    startPoint: .leading,
                    endPoint: .trailing)
                  .frame(width: 32, height: expandButton.text.heightOfString(usingFont: expandButton.font))
                  
                  Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: expandButton.text.widthOfString(usingFont: expandButton.font), alignment: .center)
                }
              }
            }
          }
          .frame(height: expandButton.text.heightOfString(usingFont: font))
        }
      )
      
      if truncated {
        if !expand {
          Button(action: {
            self.expand = true
            self.isFold.toggle()
          }, label: {
            Text(expandButton.text)
              .font(Font(expandButton.font))
              .foregroundColor(expandButton.color)
          })
        }
      }
    }
    .background(
      ZStack{
        if !truncated {
          if fullSize != 0 {
            Text(text)
              .font(Font(font))
              .lineLimit(lineLimit)
              .background(
                GeometryReader { geo in
                  Color.clear
                    .onAppear {
                      if fullSize > geo.size.height {
                        self.truncated = true
                        print(geo.size.height)
                      }
                    }
                }
              )
          }
          
          Text(text)
            .font(Font(font))
            .lineLimit(999)
            .fixedSize(horizontal: false, vertical: true)
            .background(GeometryReader { geo in
              Color.clear
                .onAppear() {
                  self.fullSize = geo.size.height
                }
            })
        }
      }
        .hidden()
    )
  }
}
