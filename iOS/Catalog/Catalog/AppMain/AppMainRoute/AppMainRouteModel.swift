//
//  NavigationStaet.swift
//  Catalog
//
//  Created by Jung peter on 8/3/23.
//

import Foundation

enum AppMainRouteModel {

  struct ViewState: Equatable {
    static func == (lhs: AppMainRouteModel.ViewState, rhs: AppMainRouteModel.ViewState) -> Bool {
      lhs.currentPage == rhs.currentPage
    }

    var currentPage: Int
    var showQuotationSummarySheet: Bool
    var alertCase: AppMainRouteView.AlertCase
    var showAlert: Bool

  }
  
  struct State: Equatable {
    
  }
  
  enum ViewAction: Equatable {
    case onTapNavTab(index: Int)
    case onTapFinish
    case onTapLogo
    case onTapSwitchVehicleModel
    case onTapSimilarQuotationButton
    case onTapSimilarQuotationBackButton
    case showAlertChanged(showAlert: Bool)
  }
}
