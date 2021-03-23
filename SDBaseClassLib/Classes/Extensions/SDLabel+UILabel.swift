//
//  SDLabel+UILabel.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/3/23.
//  Copyright © 2021 奋斗青年. All rights reserved.
//

import Foundation

public extension UILabel {
    @discardableResult
    func setTextAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }
    
    @discardableResult
    func setText(_ text: String?) -> Self {
        self.text = text
        return self
    }
    
    @discardableResult
    func setTextColor(_ color: UIColor) -> Self {
        self.textColor = color
        return self
    }
    
    ///添加下划线
    @discardableResult
    func underline() -> Self  {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
        return self
        
    }
    
    @discardableResult
    func setNumberLines(_ numberOfLines: Int) -> Self {
        self.numberOfLines = numberOfLines
        return self
    }
}
