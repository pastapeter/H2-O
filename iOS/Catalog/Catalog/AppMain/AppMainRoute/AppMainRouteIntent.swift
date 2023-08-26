//
//  NavigationIndent.swift
//  Catalog
//
//  Created by Jung peter on 8/3/23.
//

import Foundation
import Combine

final class AppMainRouteIntent: ObservableObject {
  
  // MARK: - LifeCycle
  
  init(initialState: State) {
    state = initialState
  }
  
  // MARK: - Internal
  
  @Published var state: State = State(currentPage: 0,
                                      showQuotationSummarySheet: false,
                                      alertCase: .guide,
                                      showAlert: true)
  var cancellable: Set<AnyCancellable> = []
}

extension AppMainRouteIntent: AppMainRouteIntentType, IntentType {
  typealias ViewAction = AppMainRouteModel.ViewAction
  
  typealias State = AppMainRouteModel.State
  
  func mutate(action: AppMainRouteModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
      case .onTapNavTab(let index):
        //        if index != 0 && quotation.state.quotation == nil {
        //          print("페이지 이동 불가")
        //        } else {
        //        }
        state.currentPage = index
        print(state.currentPage)
        
      case .onTapFinish:
        send(action: .showAlertChanged(showAlert: true))
        state.alertCase = .quit
        
      case .onTapLogo:
        state.currentPage = 0
        
      case .onTapSwitchVehicleModel:
        print("didTapSwitchVehicleModel")
        
      case .onTapSimilarQuotationButton:
        state.showQuotationSummarySheet = true
        
      case .onTapSimilarQuotationBackButton:
        state.showQuotationSummarySheet = false
        
      case .showAlertChanged(let showAlert):
        state.showAlert = showAlert
    }
  }
}

protocol AppMainRouteIntentType: AnyObject {
  
  var state: AppMainRouteModel.State { get }
  
  func send(action: AppMainRouteModel.ViewAction)
  
  func send(action: AppMainRouteModel.ViewAction, viewEffect: (() -> Void)?)
  
}
