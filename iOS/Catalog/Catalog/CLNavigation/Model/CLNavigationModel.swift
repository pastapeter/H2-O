//
//  NavigationStaet.swift
//  Catalog
//
//  Created by Jung peter on 8/3/23.
//

import Foundation

enum CLNavigationModel {

  struct State: Equatable {
    static func == (lhs: CLNavigationModel.State, rhs: CLNavigationModel.State) -> Bool {
      lhs.currentPage == rhs.currentPage
    }

    var currentPage: Int
    var showQuotationSummarySheet: Bool
    var alertCase: CLNavigationView.AlertCase
    var showAlert: Bool

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
