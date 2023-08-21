//
//  ExpandableTextHelperFunction.swift
//  Catalog
//
//  Created by Jung peter on 8/22/23.
//

import SwiftUI

extension ExpandableText {
    public func font(_ font: UIFont) -> ExpandableText {
        var result = self
        
        result.font = font
        
        return result
    }
    public func lineLimit(_ lineLimit: Int) -> ExpandableText {
        var result = self
        
        result.lineLimit = lineLimit
        return result
    }
    
    public func foregroundColor(_ color: Color) -> ExpandableText {
        var result = self
        
        result.foregroundColor = color
        return result
    }
    
    public func expandButton(_ expandButton: TextSet) -> ExpandableText {
        var result = self
        
        result.expandButton = expandButton
        return result
    }
    
}

extension String {
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}

struct TextSet {
    var text: String
    var font: UIFont
    var color: Color

   init(text: String, font: CatalogTextType, color: Color) {
        self.text = text
        self.font = font.font
        self.color = color
    }
}
