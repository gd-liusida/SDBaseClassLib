//
//  UIBarButtonItem+Extension.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/4/3.
//

import UIKit

extension UIBarButtonItem: SDPOPCompatible {}

// MARK:- 一、基本的扩展
public extension SDPOP where Base: UIBarButtonItem {
    
    // MARK: 1.1、快捷创建 UIBarButtonItem
    static func createBarbuttonItem(name: String, target: Any?, action: Selector) -> UIBarButtonItem {
        let rightBtn = UIButton()
        rightBtn.setImage(UIImage(named: name), for: UIControl.State.normal)
        rightBtn.setImage(UIImage(named: name + "_highlighted"), for: UIControl.State.highlighted)
        // button自适应大小
        rightBtn.sizeToFit()
        rightBtn.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
        return UIBarButtonItem(customView:rightBtn)
    }
    
}

