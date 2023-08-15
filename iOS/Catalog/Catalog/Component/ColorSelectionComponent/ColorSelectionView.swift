//
//  ColorSelectionView.swift
//  Catalog
//
//  Created by Jung peter on 8/15/23.
//

import SwiftUI

protocol ColorSelectionCell: View {

  associatedtype ColorDisplayingContent: ColorContentable

  var action: () -> Void { get }

  var colorState: ColorInfoState { get }

  var body: ColorSelectionComponent<ColorDisplayingContent> { get }

}

struct ColorSelectionView<ColorDisplayingContent: ColorContentable>: ColorSelectionCell {

  private(set) var action: () -> Void

  private(set) var colorState: ColorInfoState

  var body: ColorSelectionComponent<ColorDisplayingContent> {
    ColorSelectionComponent(action: action, state: colorState) {
      ColorDisplayingContent(isSelected: colorState.isSelected, color: colorState.colorType)
    }
  }

}

extension ColorSelectionView {
  @ViewBuilder
  static func build(action: @escaping () -> Void, colorState: ColorInfoState) -> some View {
    ColorSelectionView(action: action, colorState: colorState)
  }
}
