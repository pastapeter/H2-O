//
//  ContentPopupProtocol.swift
//  Catalog
//
//  Created by Jung peter on 8/11/23.
//

import SwiftUI

protocol ModalPopUpContentable: View { }

extension Rectangle: ModalPopUpContentable { }

protocol ModalPopUpView: View {

  associatedtype ModalPopUpContent: ModalPopUpContentable

  var action: () -> Void { get }

  var body: AlertViewComponent<ModalPopUpContent> { get }

}
