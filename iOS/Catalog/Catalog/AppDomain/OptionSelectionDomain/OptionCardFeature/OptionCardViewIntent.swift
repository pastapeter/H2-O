//
//  OptionCardViewIntent.swift
//  Catalog
//
//  Created by Jung peter on 8/18/23.
//

import Foundation
import Combine

protocol OptionCardViewIntentType {
  
  var viewState: OptionCardModel.ViewState { get }
  var state: OptionCardModel.State { get }

  func send(action: OptionCardModel.ViewAction)

  func send(action: OptionCardModel.ViewAction, viewEffect: (() -> Void)?)
  
}

final class OptionCardViewIntent: ObservableObject {
  
  init(initialState: ViewState, parent: OptionCardScrollIntentType, repository: OptionSelectionRepositoryProtocol) {
    viewState = initialState
    self.parent = parent
    self.repository = repository
  }
  
  typealias ViewState = OptionCardModel.ViewState
  typealias State = OptionCardModel.State
  typealias ViewAction = OptionCardModel.ViewAction
  
  @Published var viewState: ViewState
  var state: OptionCardModel.State = .init()
  
  var cancellable: Set<AnyCancellable> = []
  weak var parent: OptionCardScrollIntentType?
  private var repository: OptionSelectionRepositoryProtocol
  
}

extension OptionCardViewIntent: OptionCardViewIntentType, IntentType {
  
  func mutate(action: OptionCardModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
    case .onTapDetail:
      
      Task {
        do {
          if viewState.isPackage {
            viewState.packageOption = try await repository.fetchPackageInfo(of: viewState.id)
            await MainActor.run(body: {
              viewEffect?()
            })
          } else {
            viewState.defaultOptionDetail = try await repository.fetchDetailInfo(of: viewState.id)
            await MainActor.run(body: {
              viewEffect?()
            })
          }
        } catch (let e) {
          print(e)
        }
        
      }
      
    case .onTap(let option):
        parent?.send(action: .onTapOption(id: option))
      viewEffect?()
    }
  }
  
}
