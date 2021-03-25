//
//  SDTextField+UITextField.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/3/25.
//

import UIKit

public extension UITextField {
    
    private struct PlaceholderColorKey {
        static var identifier: String = "PlaceholderColorKey"
    }
    
    var placeholderColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, PlaceholderColorKey.identifier) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, PlaceholderColorKey.identifier, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            let attStr = NSMutableAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: newValue ?? UIColor.gray, NSAttributedString.Key.font: self.font ?? UIFont.systemFont(ofSize: 14)])
            self.attributedPlaceholder = attStr
        }
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
    
    @discardableResult
    func setPlaceholder(_ placeholder: String?) -> Self {
        self.placeholder = placeholder
        return self
    }
    
    @discardableResult
    func setPlaceholderColor(_ color: UIColor) -> Self {
        self.setValue(color, forKeyPath: "placeholderLabel.textColor")
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
    
    @discardableResult
    func setTextLeftAlignment() -> Self {
        self.textAlignment = .left
        return self
    }
    
    @discardableResult
    func setTextCenterAlignment() -> Self {
        self.textAlignment = .center
        return self
    }
    
    @discardableResult
    func setTextRightAlignment() -> Self {
        self.textAlignment = .right
        return self
    }
    
    
}
