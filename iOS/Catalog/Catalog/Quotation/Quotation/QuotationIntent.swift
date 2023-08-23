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
  
  private init(initialState: State, repository: QuotationRepositoryProtocol) {
    state = initialState
    self.repostitory = repository
  }
  
  @Published var state: State = .init(
    totalPrice: CLNumber(0),
    minPrice: CLNumber(0),
    maxPrice: CLNumber(99999999))
  var cancellable: Set<AnyCancellable> = []
  private var repostitory: QuotationRepositoryProtocol
}

extension Quotation: QuotationIntentType, IntentType {
  
  typealias State = QuotationModel.State
  typealias ViewAction = QuotationModel.ViewAction
  
  func mutate(action: QuotationModel.ViewAction, viewEffect: (() -> Void)?) {
    switch action {
      case .isTrimSelected(let carQuotation, let minPrice, let maxPrice):
        state.quotation = carQuotation
        state.minPrice = minPrice
        state.maxPrice = maxPrice
        send(action: .isPriceChanged)
        
      case .isTrimChanged(let trim):
        state.quotation?.trim = trim
        send(action: .isPriceChanged)
        
      case .isPowertrainChanged(let powertrain):
        state.quotation?.powertrain = powertrain
        send(action: .isPriceChanged)
        
      case .isBodyTypeChanged(let bodytype):
        state.quotation?.bodytype = bodytype
        send(action: .isPriceChanged)
        
      case .isDrivetrainChanged(let drivetrain):
        state.quotation?.drivetrain = drivetrain
        send(action: .isPriceChanged)
        
        // TODO: - 색상 모델 채우기
      case .isExternalColorChanged: return
      case .isInternalColorChanged: return
      case .isOptionChanged(let option): return
        
      case .isPriceChanged:
        state.totalPrice = (state.quotation?.calculateTotalPrice() ?? CLNumber(0))
      case .onTapCompleteButton:
        Task {
          do {
             if let requestQuotation = state.quotation {
               let quotationId = try await repostitory.saveFinalQuotation(with: requestQuotation)
               print(quotationId)
            }
          } catch let error {
            print(error.localizedDescription)
          }
        }
      case .similarOptionsAdded(let options):
        state.quotation?.options.append(contentsOf: options)
      case .similarOptionsDeleted(let optionIndex):
        state.quotation?.options = (state.quotation?.options.filter{$0.id != optionIndex}) ?? []
    }
  }
}

//extension Quotation: QuotationPriceViewable {
//  
//  private(set) var totalQuotationPrice: CLNumber {
//    return state.totalPrice
//  }
//  
//}


protocol QuotationIntentType {
  
  var state: QuotationModel.State { get }
  
  func send(action: QuotationModel.ViewAction)
  
  func send(action: QuotationModel.ViewAction, viewEffect: (() -> Void)?)
  
}

extension Quotation: QuotationCompleteService {
  func getModelName() -> String {
    return state.quotation?.model.name ?? ""
  }
  
  func getPowertrainAndDriveTrain() -> (Int, Int) {
    guard let powertrainId = state.quotation?.powertrain.id else { return (0, 0) }
    guard let drivetrainId = state.quotation?.drivetrain.id else { return (0, 0) }
    return (powertrainId, drivetrainId)
  }
  
  func getSummary() -> SummaryCarQuotation {
    return state.quotation?.toSummary() ?? SummaryCarQuotation.mock()
  }
}
