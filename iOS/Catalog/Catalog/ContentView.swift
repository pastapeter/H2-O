//
//  ContentView.swift
//  Catalog
//
//  Created by Jung peter on 8/1/23.
//

import SwiftUI

struct ContentView: View {
    @State var buttonState: CLButton.CLButtonState = .default
    var body: some View {
        VStack {
            Image("logo")
                .imageScale(.large)
                .foregroundColor(.accentColor)
          Text("Hello, world!").catalogFont(type: .HeadENBold26)
          
            CLButton(buttonState: $buttonState,
                mainText: "Le Blanc 선택하기",
                                inActiveText: "옵션을 선택해 추가해보세요.",
                     height: 52, buttonAction: { print("clicked") })
            CLDualChoiceButton(leftText: "취소",
                               rightText: "완료",
                               height: 52,
                               leftAction: { print("left")},
                               rightAction: { print("right")})
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
