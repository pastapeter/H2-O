//
//  ExteriorSelectionIntentType.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import Foundation
import Combine

protocol ExteriorSelectionIntentType {
  
  var state: ExteriorSelectionModel.State { get }
  var viewState: ExteriorSelectionModel.ViewState { get }
  
  func send(action: ExteriorSelectionModel.ViewAction)
  
  func send(action: ExteriorSelectionModel.ViewAction, viewEffect: (() -> Void)?)
  
}

final class ExternalSelectionIntent: ObservableObject {
  
  init(initialViewState: ViewState, repository: ExteriorColorRepositoryProtocol, quotation: ExteriorSelectionService) {
    viewState = initialViewState
    self.repository = repository
    self.quotation = quotation
  }
  
  private var repository: ExteriorColorRepositoryProtocol
  
  typealias State = ExteriorSelectionModel.State
  typealias ViewState = ExteriorSelectionModel.ViewState
  typealias ViewAction = ExteriorSelectionModel.ViewAction
  
  @Published var viewState: ExteriorSelectionModel.ViewState
  var state: State = .init()
  
  var cancellable: Set<AnyCancellable> = []
  
  private var quotation: ExteriorSelectionService
  let imageCacher = ImageCacheService.shared
  var imgs: [Data] = Array(repeating: Data(), count: 60)
}

extension ExternalSelectionIntent: ExteriorSelectionIntentType, IntentType {
  
  func mutate(action: ExteriorSelectionModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
      case .onAppear:
        Task {
          do {
            let externalColors = try await repository.fetch(with: viewState.selectedTrimId)
            send(action: .fetchColors(colors: externalColors))
          } catch let _ {
            // TODO: Error Handling
          }
        }
      case .fetchColors(let colors):
        let colorStates = colors.map { ExteriorColorState(isSelected: false, color: $0) }
        viewState.colors = colorStates
        let colorCount = viewState.colors.count
       viewState.images = Array(repeating: [], count: colorCount)
        Task {
          do {
            for i in 0..<colorCount {
              for urlIndex in 0..<viewState.colors[colorCount-1].color.exteriorImages.count {
                imgs[urlIndex] = try await imageCacher.setImage(viewState.colors[i].color.exteriorImages[urlIndex])
              }
              viewState.images[i] = imgs
            }
          } catch {
              print("@@@에러")
          }
        }
        if !colorStates.isEmpty {
          send(action: .onTapColor(id: colorStates[0].color.id))
          // TODO:
        }
      case .changeSelectedExteriorImageURL:
        print("External Image Urls")
      case .onTapColor(let id):
      viewState.selectedColorId = id
      viewState.currentSelectedIndex = viewState.colors.firstIndex(where: {$0.color.id == id}) ?? 0
        
      quotation.updateExteriorColor(to: viewState.colors.first(where: { $0.color.id == id })?.color)
      
        for i in viewState.colors.indices {
          if viewState.colors[i].color.id == id {
            viewState.colors[i].isSelected = true
            send(action: .changeSelectedExteriorImageURL(url: viewState.colors[i].color.exteriorImages))
          } else {
            viewState.colors[i].isSelected = false
          }
        }
    }
  }
  
}
