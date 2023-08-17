//
//  Font+.swift
//  Catalog
//
//  Created by Jung peter on 8/1/23.
//

import SwiftUI

enum CatalogTextType {

  case HeadENBold26
  case HeadENBold24
  case HeadENBold22
  case HeadENMedium20
  case HeadENMedium10
  case HeadENBold10

  case HeadENRegular28

  case TextENMedium18
  case TextENMedium16
  case TextENMedium14
  case TextENMedium10

  case CaptionENMedium14
  case CaptionENMedium12
  case HeadKRBold65
  case HeadKRBold32
  case HeadKRBold26
  case HeadKRBold24
  case HeadKRBold22
  case HeadKRBold20
  case HeadKRBold18
  case TextKRBold12

  case HeadKRMedium26
  case HeadKRMedium24
  case HeadKRMedium22
  case HeadKRMedium20
  case HeadKRMedium18
  case HeadKRMedium16
  case HeadKRMedium14
  case TextKRMedium18
  case TextKRMedium16
  case TextKRMedium14
  case TextKRMedium12
  case TextKRMedium10

  case HeadKRRegular26
  case HeadKRRegular24
  case HeadKRRegular22
  case HeadKRRegular20

  case TextKRRegular18
  case TextKRRegular16
  case TextKRRegular14
  case TextKRRegular12
  case TextKRRegular10

}

// MARK: - letterSpacing

extension CatalogTextType {
  var letterSpacing: CGFloat {
    switch self {
    case .HeadENBold26:
      return -0.1
    case .HeadENBold24:
      return -0.1
    case .HeadENBold22:
      return -0.1
    case .HeadENMedium20:
      return -0.1
    case .HeadENMedium10:
      return -0.1
    case .HeadENBold10:
      return -0.1
    case .TextENMedium18:
      return -0.1
    case .TextENMedium16:
      return -0.1
    case .TextENMedium14:
      return -0.1
    case .TextENMedium10:
      return -0.1
    case .CaptionENMedium14:
      return -0.1
    case .CaptionENMedium12:
      return -0.1
    case .HeadKRBold32:
      return -0.3
    case .HeadKRBold26:
      return -0.3
    case .HeadKRBold24:
      return -0.3
    case .HeadKRBold22:
      return -0.3
    case .HeadKRBold20:
      return -0.3
    case .HeadKRBold18:
      return -0.3
    case .TextKRBold12:
      return -0.3
    case .HeadKRMedium26:
      return -0.3
    case .HeadKRMedium24:
      return -0.3
    case .HeadKRMedium22:
      return -0.3
    case .HeadKRMedium20:
      return -0.3
    case .HeadKRMedium18:
      return -0.3
    case .HeadKRMedium16:
      return -0.3
    case .HeadKRMedium14:
      return -0.3
    case .TextKRMedium18:
      return -0.3
    case .TextKRMedium16:
      return -0.3
    case .TextKRMedium14:
      return -0.3
    case .TextKRMedium12:
      return -0.3
    case .TextKRMedium10:
      return -0.3
    case .HeadKRRegular26:
      return -0.3
    case .HeadKRRegular24:
      return -0.3
    case .HeadKRRegular22:
      return -0.3
    case .HeadKRRegular20:
      return -0.3
    case .TextKRRegular18:
      return -0.3
    case .TextKRRegular16:
      return -0.3
    case .TextKRRegular14:
      return -0.3
    case .TextKRRegular12:
      return -0.3
    case .TextKRRegular10:
      return -0.3
    case .HeadENRegular28:
      return -0.1
    case .HeadKRBold65:
      return -0.3
    }
  }
}

// MARK: - UIFont

extension CatalogTextType {
  var font: UIFont {
    switch self {
    case .HeadENBold26:
      return UIFont(name: "HyundaiSansHead-Bold", size: 26)!
    case .HeadENBold24:
      return UIFont(name: "HyundaiSansHead-Bold", size: 24)!
    case .HeadENBold22:
      return UIFont(name: "HyundaiSansHead-Bold", size: 22)!
    case .HeadENMedium20:
      return UIFont(name: "HyundaiSansHeadMedium", size: 20)!
    case .HeadENBold10:
      return UIFont(name: "HyundaiSansHead-Bold", size: 10)!
    case .HeadKRBold65:
        return UIFont(name: "HyundaiSansTextKROTFBold", size: 65.24)!
    case .HeadKRBold32:
      return UIFont(name: "HyundaiSansHeadKROTFBold", size: 32)!
    case .HeadKRBold26:
      return UIFont(name: "HyundaiSansHeadKROTFBold", size: 26)!
    case .HeadKRBold24:
      return UIFont(name: "HyundaiSansHeadKROTFBold", size: 24)!
    case .HeadKRBold22:
      return UIFont(name: "HyundaiSansHeadKROTFBold", size: 22)!
    case .HeadKRBold20:
      return UIFont(name: "HyundaiSansHeadKROTFBold", size: 20)!
    case .HeadKRBold18:
      return UIFont(name: "HyundaiSansHeadKROTFBold", size: 18)!
    case .HeadKRMedium26:
      return UIFont(name: "HyundaiSansHeadKROTFMedium", size: 26)!
    case .HeadKRMedium24:
      return UIFont(name: "HyundaiSansHeadKROTFMedium", size: 24)!
    case .HeadKRMedium22:
      return UIFont(name: "HyundaiSansHeadKROTFMedium", size: 22)!
    case .HeadKRMedium20:
      return UIFont(name: "HyundaiSansHeadKROTFMedium", size: 20)!
    case .HeadKRMedium18:
      return UIFont(name: "HyundaiSansHeadKROTFMedium", size: 18)!
    case .HeadKRMedium16:
      return UIFont(name: "HyundaiSansHeadKROTFMedium", size: 16)!
    case .HeadKRMedium14:
      return UIFont(name: "HyundaiSansHeadKROTFMedium", size: 14)!
    case .HeadKRRegular26:
      return UIFont(name: "HyundaiSansHeadKROTFRegular", size: 26)!
    case .HeadKRRegular24:
      return UIFont(name: "HyundaiSansHeadKROTFRegular", size: 24)!
    case .HeadKRRegular22:
      return UIFont(name: "HyundaiSansHeadKROTFRegular", size: 22)!
    case .HeadKRRegular20:
      return UIFont(name: "HyundaiSansHeadKROTFRegular", size: 20)!
    case .TextENMedium18:
      return UIFont(name: "HyundaiSansText-Medium", size: 18)!
    case .TextENMedium16:
      return UIFont(name: "HyundaiSansText-Medium", size: 16)!
    case .TextENMedium14:
      return UIFont(name: "HyundaiSansText-Medium", size: 14)!
    case .TextENMedium10:
      return UIFont(name: "HyundaiSansText-Medium", size: 10)!
    case .CaptionENMedium14:
      return UIFont(name: "HyundaiSansText-Medium", size: 14)!
    case .CaptionENMedium12:
      return UIFont(name: "HyundaiSansText-Medium", size: 12)!
    case .TextKRBold12:
      return UIFont(name: "HyundaiSansTextKROTFBold", size: 12)!
    case .TextKRMedium18:
      return UIFont(name: "HyundaiSansTextKROTFMedium", size: 18)!
    case .TextKRMedium16:
      return UIFont(name: "HyundaiSansTextKROTFMedium", size: 16)!
    case .TextKRMedium14:
      return UIFont(name: "HyundaiSansTextKROTFMedium", size: 14)!
    case .TextKRMedium12:
      return UIFont(name: "HyundaiSansTextKROTFMedium", size: 12)!
    case .TextKRMedium10:
      return UIFont(name: "HyundaiSansTextKROTFMedium", size: 10)!
    case .TextKRRegular18:
      return UIFont(name: "HyundaiSansTextKROTFRegular", size: 18)!
    case .TextKRRegular16:
      return UIFont(name: "HyundaiSansTextKROTFRegular", size: 16)!
    case .TextKRRegular14:
      return UIFont(name: "HyundaiSansTextKROTFRegular", size: 14)!
    case .TextKRRegular12:
      return UIFont(name: "HyundaiSansTextKROTFRegular", size: 12)!
    case .TextKRRegular10:
      return UIFont(name: "HyundaiSansTextKROTFRegular", size: 10)!
    case .HeadENMedium10:
      return UIFont(name: "HyundaiSansHeadMedium", size: 10)!
    case .HeadENRegular28:
      return UIFont(name: "HyundaiSansHead", size: 28)!

    }
  }
}

// MARK: - LineHeight

extension CatalogTextType {

  var lineHeight: CGFloat {
    switch self {
    case .HeadENBold26:
      return 36
    case .HeadENBold24:
      return 32
    case .HeadENBold22:
      return 28
    case .HeadENMedium20:
      return 28
    case .HeadENMedium10:
      return 12.36
    case .HeadENBold10:
      return 12
    case .HeadKRBold32, .HeadKRBold26:
      return 36
    case .HeadKRBold24:
      return 32
    case .HeadKRBold22:
      return 28
    case .HeadKRBold20:
      return 24
    case .HeadKRBold18:
      return 28
    case .TextKRBold12:
      return 18
    case .HeadKRMedium26:
      return 36
    case .HeadKRMedium24:
      return 32
    case .HeadKRMedium22:
      return 28
    case .HeadKRMedium20:
      return 24
    case .HeadKRMedium18:
      return 28
    case .HeadKRMedium16:
      return 24
    case .HeadKRMedium14:
      return 22
    case .HeadKRRegular26:
      return 36
    case .HeadKRRegular24:
      return 32
    case .HeadKRRegular22:
      return 28
    case .HeadKRRegular20:
      return 24
    case .TextENMedium18:
      return 28
    case .TextENMedium16:
      return 24
    case .TextENMedium14:
      return 22
    case .TextENMedium10:
      return 12.36
    case .CaptionENMedium14:
      return 28
    case .CaptionENMedium12:
      return 24
    case .TextKRMedium18:
      return 18
    case .TextKRMedium16:
      return 18
    case .TextKRMedium14:
      return 22
    case .TextKRMedium12:
      return 18
    case .TextKRMedium10:
      return 16

    case .TextKRRegular18:
      return 18
    case .TextKRRegular16:
      return 18
    case .TextKRRegular14:
      return 18
    case .TextKRRegular12:
      return 18
    case .TextKRRegular10:
      return 18
    case .HeadENRegular28:
      return 35
    case .HeadKRBold65:
      return 81.55
    }
  }
}

struct CatalogFont: ViewModifier {
  let font: UIFont
  let lineHeight: CGFloat

  func body(content: Content) -> some View {
    content
      .font(Font(font))
      .lineSpacing(lineHeight - font.lineHeight)
      .padding(.vertical, (lineHeight - font.lineHeight) / 2)
  }
}

extension Text {
  func catalogFont(type: CatalogTextType) -> some View {
    ModifiedContent(content: self.tracking(type.letterSpacing),
                    modifier: CatalogFont(font: type.font, lineHeight: type.lineHeight))
  }
}
