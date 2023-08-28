//
//  QuotationState.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/16.
//

import Foundation
import Combine

protocol QuotationPriceViewable {
  var totalQuotationPrice: CLNumber { get }
}


final class Quotation: ObservableObject {
  
  static let shared = Quotation(initialState: .init(totalPrice: CLNumber(0), minPrice: CLNumber(50000000), maxPrice: CLNumber(99999999)),
                                repository: QuotationRepository(quotationRequestManager: RequestManager(apiManager: APIManager())))
  
  private init(initialState: ViewState, repository: QuotationRepositoryProtocol) {
    viewState = initialState
    self.repostitory = repository
  }
  
  @Published var viewState: ViewState = .init(
    totalPrice: CLNumber(0),
    minPrice: CLNumber(0),
    maxPrice: CLNumber(99999999))
  var cancellable: Set<AnyCancellable> = []
  private var repostitory: QuotationRepositoryProtocol
}

extension Quotation: QuotationIntentType, IntentType {
  
  typealias ViewState = QuotationModel.State
  typealias ViewAction = QuotationModel.ViewAction
  
  func mutate(action: QuotationModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
      case .isTrimSelected(let carQuotation, let minPrice, let maxPrice):
      viewState.quotation = carQuotation
        viewState.minPrice = minPrice
        viewState.maxPrice = maxPrice
        send(action: .isPriceChanged)
        
      case .isTrimChanged(let trim):
        viewState.quotation?.trim = trim
        send(action: .isPriceChanged)
        
      case .isPowertrainChanged(let powertrain):
        viewState.quotation?.powertrain = powertrain
        send(action: .isPriceChanged)
        
      case .isBodyTypeChanged(let bodytype):
        viewState.quotation?.bodytype = bodytype
        send(action: .isPriceChanged)
        
      case .isDrivetrainChanged(let drivetrain):
        viewState.quotation?.drivetrain = drivetrain
        send(action: .isPriceChanged)
        
        // TODO: - 색상 모델 채우기
      case .isExternalColorChanged: return
      case .isInternalColorChanged: return
      case .isOptionChanged(let option): return
        
      case .isPriceChanged:
        viewState.totalPrice = (viewState.quotation?.calculateTotalPrice() ?? CLNumber(0))
      case .onTapCompleteButton:
        Task {
          do {
             if let requestQuotation = viewState.quotation {
               let quotationId = try await repostitory.saveFinalQuotation(with: requestQuotation)
               print(quotationId)
            }
          } catch let error {
            print(error.localizedDescription)
          }
        }
      case .similarOptionsAdded(let options):
        viewState.quotation?.options.append(contentsOf: options)
      case .similarOptionsDeleted(let optionIndex):
        viewState.quotation?.options = (viewState.quotation?.options.filter{$0.id != optionIndex}) ?? []
    }
  }
}

//extension Quotation: QuotationPriceViewable {
//  
//  private(set) var totalQuotationPrice: CLNumber {
//    return viewState.totalPrice
//  }
//  
//}


protocol QuotationIntentType {
  
  var viewState: QuotationModel.State { get }
  
  func send(action: QuotationModel.ViewAction)
  
  func send(action: QuotationModel.ViewAction, viewEffect: (() -> Void)?)
  
}

extension Quotation: QuotationCompleteService {
  func getModelName() -> String {
    return viewState.quotation?.model.name ?? ""
  }
  
  func getPowertrainAndDriveTrain() -> (Int, Int) {
    guard let powertrainId = viewState.quotation?.powertrain.id else { return (0, 0) }
    guard let drivetrainId = viewState.quotation?.drivetrain.id else { return (0, 0) }
    return (powertrainId, drivetrainId)
  }
  
  func getSummary() -> SummaryCarQuotation {
    return viewState.quotation?.toSummary() ?? SummaryCarQuotation.mock()
  }
}
