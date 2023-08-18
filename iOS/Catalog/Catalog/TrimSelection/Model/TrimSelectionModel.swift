//
//  TrimSelectionModel.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/11.
//

 import Foundation

enum TrimSelectionError: LocalizedError, Equatable {
  case TrimArrayIsEmpty
  case NoDefaultOption
  case NoSelectedTrim
  case FailedToDomain
}

extension TrimSelectionError {
  var errorDescription: String? {
    switch self {
      case .TrimArrayIsEmpty:
        return "알아서하되 같이정해봐야할듯"
      case .NoDefaultOption:
        return "default option 없음"
      case .NoSelectedTrim:
        return "trim이 선택되지 않음"
      case .FailedToDomain:
        return "엔티티로 변환 실패"
    }
  }
}

 enum TrimSelectionModel {

   struct State: Equatable {
     static func == (lhs: TrimSelectionModel.State, rhs: TrimSelectionModel.State) -> Bool {
       lhs.selectedTrim == rhs.selectedTrim
     }

     var trims: [Trim] = []
     var selectedTrim: Trim?
     var error: TrimSelectionError?
     var carId: Int
     var quoation = Quotation.shared
     var isTrimSelected: Bool = false
  }

  enum ViewAction: Equatable {
    case onTapTrimSelectButton
    case enteredTrimPage
    case trimSelected(index: Int)
    case fetchTrims(trims: [Trim])
  }
 }
