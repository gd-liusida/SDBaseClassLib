//
//  SDButton+UIButton.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/3/23.
//  Copyright © 2021 奋斗青年. All rights reserved.
//

import UIKit

public typealias ActionBlock = ((UIButton)->Void)

/// 防止按钮重复点击
public extension UIButton {
    
    private struct AssociatedKeys {
        static var ActionBlock = "ActionBlock"
        static var ActionDelay = "ActionDelay"
    }
    
    /// 运行时关联
    private var actionBlock: ActionBlock? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.ActionBlock, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.ActionBlock) as? ActionBlock
        }
    }
    
    private var actionDelay: TimeInterval {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.ActionDelay, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.ActionDelay) as? TimeInterval ?? 0
        }
    }
    
    @objc private func btnDelayClick(_ button: UIButton) {
        actionBlock?(button)
        isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + actionDelay) { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.isEnabled = true
        }
    }
    
    /// 添加点击事件
    func addAction(_ delay: TimeInterval = 0, action: @escaping ActionBlock) {
        addTarget(self, action: #selector(btnDelayClick(_:)) , for: .touchUpInside)
        actionDelay = delay
        actionBlock = action
    }
    
}

public extension UIButton {
    
    @discardableResult
    func setTitleFont(_ font: UIFont) -> Self {
        titleLabel?.font = font
        return self
    }
    
    @discardableResult
    func setNormalImage(_ imageName: String) -> Self {
        setImage(UIImage.init(named: imageName), for: .normal)
        return self
    }
    
    @discardableResult
    func setSelectedImage(_ imageName: String) -> Self {
        setImage(UIImage(named: imageName), for: .selected)
        return self
    }
    
    @discardableResult
    func setNormalTitle(_ title: String) -> Self {
        setTitle(title, for: .normal)
        return self
    }
    
    @discardableResult
    func setSelectedTitle(_ title: String) -> Self {
        setTitle(title, for: .selected)
        return self
    }
    
    @discardableResult
    func setNormalTitleColor(_ color: UIColor) -> UIButton {
        setTitleColor(color, for: .normal)
        return self
    }
    
    @discardableResult
    func setSelectedTitleColor(_ color: UIColor) -> UIButton {
        setTitleColor(color, for: .selected)
        return self
    }
    
    @discardableResult
    func setImageEdgeInsets(_ edgeInsets: UIEdgeInsets) -> UIButton {
        imageEdgeInsets = edgeInsets
        return self
    }
    
    @discardableResult
    func setTitleEdgeInsets(_ edgeInsets: UIEdgeInsets) -> UIButton {
        imageEdgeInsets = edgeInsets
        return self
    }
}
