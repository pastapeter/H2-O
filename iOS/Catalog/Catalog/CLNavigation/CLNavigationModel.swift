//
//  NavigationStaet.swift
//  Catalog
//
//  Created by Jung peter on 8/3/23.
//

import Foundation

enum CLNavigationModel {

  struct State: Equatable {
    var currentPage: Int
    
    init(currentPage: Int) {
      self.currentPage = currentPage
    }
    
  }
  
  enum ViewAction: Equatable {
    case onTapNavTab(index: Int)
    case onTapFinish
    case onTapLogo
    case onTapSwitchVehicleModel
  }

}
