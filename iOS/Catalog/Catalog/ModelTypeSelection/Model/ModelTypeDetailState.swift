//
//  ModelTypeDetailState.swift
//  Catalog
//
//  Created by Jung peter on 8/20/23.
//

import Foundation

protocol PriceContainable {
  var price: CLNumber { get }
}

protocol titleContainable {
  var title: String { get }
}

typealias ModalItemable = Identifiable & PriceContainable & titleContainable


struct ModelTypeDetailState: Equatable, ModalItemable {
  
  var id: Int
  var title: String
  var description: String?
  var choiceRatio: CLNumber?
  var imageURL: URL?
  var price: CLNumber
  var hmgData: HMGModelTypeState?
  
}
