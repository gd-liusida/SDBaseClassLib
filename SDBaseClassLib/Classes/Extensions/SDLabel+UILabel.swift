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
    func setNumberLines(_ numberOfLines: Int) -> Self {
        self.numberOfLines = numberOfLines
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
    
    @discardableResult
    func setFont(_ font: UIFont) -> Self {
        self.font = font
        return self
    }
    
    /// 字体大小自适应宽度
    /// - Parameter minScale: <#minScale description#>
    /// - Returns: <#description#>
    @discardableResult
    func setFontSizeToFitWidth(_ minScale: CGFloat = 0.6) -> Self {
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = minScale
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
    
    /// 添加删除线
    @discardableResult
    func strikethrough() -> Self {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttributes([NSAttributedString.Key.strikethroughStyle: NSNumber.init(value: 1)], range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
        return self
    }
}
