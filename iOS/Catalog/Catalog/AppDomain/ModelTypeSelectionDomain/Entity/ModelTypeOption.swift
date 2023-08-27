//
//  OptionInDetail.swift
//  Catalog
//
//  Created by Jung peter on 8/14/23.
//

import Foundation

struct ModelTypeOption: Equatable {
  
  var id: Int
  var name: String
  var choiceRatio: CLNumber?
  var price: CLNumber
  var description: String?
  var thumbnailImageURL: URL?
  var imageURL: URL?
  var maxOuputFromEngine: MaxOutputFromEngine?
  var maxTorqueFromEngine: MaxTorqueFromEngine?
  
}
