//
//  SDTextField+UITextField.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/3/25.
//

import UIKit

public extension UITextField {
    
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
    
    @discardableResult
    func setPlaceholder(_ placeholder: String?) -> Self {
        self.placeholder = placeholder
        return self
    }
    
    @discardableResult
    func setLeftView(_ leftView: UIView) -> Self {
        self.leftView = leftView
        self.leftViewMode = .always
        return self
    }
    
    @discardableResult
    func setRightView(_ rightView: UIView) -> Self {
        self.rightView = rightView
        self.rightViewMode = .always
        return self
    }
    
    
}
