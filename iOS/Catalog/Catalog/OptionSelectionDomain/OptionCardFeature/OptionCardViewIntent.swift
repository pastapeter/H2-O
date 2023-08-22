//
//  OptionCardViewIntent.swift
//  Catalog
//
//  Created by Jung peter on 8/18/23.
//

import Foundation
import Combine

protocol OptionCardViewIntentType {
  
  var state: OptionCardModel.State { get }

  func send(action: OptionCardModel.ViewAction)

  func send(action: OptionCardModel.ViewAction, viewEffect: (() -> Void)?)
  
}

final class OptionCardViewIntent: ObservableObject {
  
  init(initialState: State, parent: OptionCardScrollIntentType, repository: OptionSelectionRepositoryProtocol) {
    state = initialState
    self.parent = parent
    self.repository = repository
  }
  
  typealias State = OptionCardModel.State
  typealias ViewAction = OptionCardModel.ViewAction
  
  @Published var state: State
  
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
          if state.isPackage {
            state.packageOption = try await repository.fetchPackageInfo(of: state.id)
            await MainActor.run(body: {
              viewEffect?()
            })
          } else {
            state.defaultOptionDetail = try await repository.fetchDetailInfo(of: state.id)
            await MainActor.run(body: {
              viewEffect?()
            })
          }
        } catch (let e) {
          print(e)
        }
        
      }
      
    case .onTap(let id):
      parent?.send(action: .onTapOption(id: id))
      viewEffect?()
    }
  }
  
}
