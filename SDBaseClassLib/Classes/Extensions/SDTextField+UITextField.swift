//
//  SDTextField+UITextField.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/3/25.
//

import UIKit

extension UITextField {
    
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
    
}
