//
//  OptionModalTabContentView.swift
//  Catalog
//
//  Created by Jung peter on 8/21/23.
//

import SwiftUI

struct OptionModalTabContentView: View {
  
  @State var currentPage: Int = 0
  
    var body: some View {
      VStack(alignment: .leading) {
        CLNavigationMenuView(currentPage: $currentPage,
                             navigationMenuTitles: ["후석 승객 알림", "메탈 리어범퍼스탭", "메탈 도어스커"],
                             titleFont: .TextKRMedium14,
                             verticalSpacing:0,
                             barType: .dynamic,
                             scrollable: true)
          .frame(maxWidth: .infinity)
          .padding(.leading, CGFloat(30).scaledWidth)
        
        TabView(selection: $currentPage) {
          OptionModalContentView(hashTags: ["장거리 운전", "다자녀", "안전"], description: "시동이 걸린 상태에서 해당 좌석의 통풍 스위치를 누르면 표시등이 켜지면서 해당 좌석에 바람이 나오는 편의장치입니다. 시동이 걸린 상태에서 해당 좌석의 통풍 스위치를 누르면 표시등이 켜지면서 해당 좌석에 바람이 나오는 편의장치입니다.").tag(0)
          
          OptionModalContentView(hashTags: ["장거리 운전", "다자녀", "안전"], description: "").tag(1)
          
          OptionModalContentView(hashTags: ["장거리 운전"], description: "시동이 걸린 상태에서 해당 좌석의 통풍 스위치를 누르면 표시등이 켜지면서 해당 좌석에 바람이 나오는 편의장치입니다. 시동이 걸린 상태에서 해당 좌석의 통풍 스위치를 누르면 표시등이 켜지면서 해당 좌석에 바람이 나오는 편의장치입니다.").tag(2)
        }
        .onAppear {
          UIScrollView.appearance().isScrollEnabled = true
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
      }
    }
}

struct OptionModalTabContentView_Previews: PreviewProvider {
    static var previews: some View {
        OptionModalTabContentView()
    }
}
