//
//  OptionCardModel.swift
//  Catalog
//
//  Created by Jung peter on 8/18/23.
//

import Foundation

enum OptionCardModel {

  struct ViewState: Equatable, Hashable, QuotationOptionable {
    
    
    static func == (lhs: OptionCardModel.ViewState, rhs: OptionCardModel.ViewState) -> Bool {
      lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
    
    var id: Int
    var isPackage: Bool = false
    var hashTags: [String]
    var name: String
    var choiceRatio: CLNumber?
    var imageURL: URL?
    var price: CLNumber?
    var containsHmgData: Bool
    var category: OptionCategory
    var defaultOptionDetail: DetailOptionInfo = .mock()
    var packageOption: PackageInfo = .mock()
    var isSimilarOption: Bool = false

  }
  
  struct State: Equatable {
    
  }

  enum ViewAction {
    case onTapDetail
    case onTap(option: OptionCardModel.ViewState)
  }
}
