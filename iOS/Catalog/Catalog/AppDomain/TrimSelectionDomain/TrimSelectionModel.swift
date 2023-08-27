//
//  TrimSelectionModel.swift
//  Catalog
//
//  Created by 이수민 on 2023/08/11.
//

 import Foundation

enum TrimSelectionError: LocalizedError, Equatable {
  case TrimArrayIsEmpty
}

extension TrimSelectionError {
  var errorDescription: String? {
    switch self {
      case .TrimArrayIsEmpty:
        return "알아서하되 같이정해봐야할듯"
    }
  }
}

 enum TrimSelectionModel {

   struct State: Equatable {

     var trims: [Trim] = []
     var selectedTrim: Trim?
     var error: TrimSelectionError?
     var vehicleId: Int
  }

  enum ViewAction: Equatable {
    case onTapTrimSelectButton
    case enteredTrimPage
    case trimSelected(index: Int)
    case fetchTrims(trims: [Trim])
  }
 }
