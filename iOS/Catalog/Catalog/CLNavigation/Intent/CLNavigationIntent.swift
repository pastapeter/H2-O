//
//  NavigationIndent.swift
//  Catalog
//
//  Created by Jung peter on 8/3/23.
//

import Foundation
import Combine

final class CLNavigationIntent: ObservableObject {
  
  // MARK: - LifeCycle
  
  init(initialState: ViewState) {
    viewState = initialState
  }
  
  // MARK: - Internal
  
  @Published var viewState: ViewState = ViewState(currentPage: 0,
                                      showQuotationSummarySheet: false,
                                      alertCase: .guide,
                                      showAlert: true)
  var quotation = Quotation.shared
  var cancellable: Set<AnyCancellable> = []
}

extension CLNavigationIntent: CLNavigationIntentType, IntentType {
  typealias ViewAction = CLNavigationModel.ViewAction
  
  typealias ViewState = CLNavigationModel.State
  
  func mutate(action: CLNavigationModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
      case .onTapNavTab(let index):
        //        if index != 0 && quotation.state.quotation == nil {
        //          print("페이지 이동 불가")
        //        } else {
        //        }
        viewState.currentPage = index
        
      case .onTapFinish:
        send(action: .showAlertChanged(showAlert: true))
        viewState.alertCase = .quit
        
      case .onTapLogo:
        viewState.currentPage = 0
        
      case .onTapSwitchVehicleModel:
        print("didTapSwitchVehicleModel")
        
      case .onTapSimilarQuotationButton:
        viewState.showQuotationSummarySheet = true
        
      case .onTapSimilarQuotationBackButton:
        viewState.showQuotationSummarySheet = false
        
      case .showAlertChanged(let showAlert):
        viewState.showAlert = showAlert
    }
  }
}

protocol CLNavigationIntentType: AnyObject {
  
  var viewState: CLNavigationModel.State { get }
  
  func send(action: CLNavigationModel.ViewAction)
  
  func send(action: CLNavigationModel.ViewAction, viewEffect: (() -> Void)?)
  
}
