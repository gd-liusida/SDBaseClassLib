//
//  SDView+UIView.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/3/22.
//  Copyright © 2021 奋斗青年. All rights reserved.
//

import Foundation
import UIKit

public typealias SDTapActionBlock = ((UIView) -> Void)

public extension UIView {
    
    private struct SDAssociatedKeys {
        static var ActionBlock = "ActionBlock"
        static var ActionDelay = "ActionDelay"
    }
    
    private var actionBlock: SDTapActionBlock? {
        set {
            objc_setAssociatedObject(self, &SDAssociatedKeys.ActionBlock, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &SDAssociatedKeys.ActionBlock) as? SDTapActionBlock
        }
    }
    
    private var actionDelay: TimeInterval {
        set {
            objc_setAssociatedObject(self, &SDAssociatedKeys.ActionDelay, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &SDAssociatedKeys.ActionDelay) as? TimeInterval ?? 0
        }
    }
    
    func addSubViews(_ views: [UIView]) {
        views.forEach { (item) in
            addSubview(item)
        }
    }
    
    @discardableResult
    func setCornerRadius(_ cornerRaidus: CGFloat, maskToBounds: Bool = true) -> Self {
        layer.masksToBounds = maskToBounds
        layer.cornerRadius = cornerRaidus
        return self
    }
    
    @discardableResult
    func setBorderWidth(_ borderWidth: CGFloat) -> Self {
        layer.borderWidth = borderWidth
        return self
    }
    
    @discardableResult
    func setBorderColor(_ borderColor: UIColor?) -> Self {
        layer.borderColor = borderColor?.cgColor
        return self
    }
    
    @discardableResult
    func setBackgroundColor(_ color: UIColor?) -> Self {
        backgroundColor = color
        return self
    }
    
    func addGestureAction(_ delay: TimeInterval = 0, action: @escaping SDTapActionBlock) {
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapDelayClick)))
        actionDelay = delay
        actionBlock = action
    }
    
    @objc func tapDelayClick() {
        actionBlock?(self)
    }
}
