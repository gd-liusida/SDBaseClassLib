//
//  UINavigationBar+Extension.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/4/3.
//

import UIKit

// MARK:- 一、基本的扩展
fileprivate var SDStateBarViewKey = "SDStateBarViewKey"

public extension UINavigationBar {
    
    // MARK: 1.1、通过 Runtime 的属性关联添加自定义 View
    /// 通过 Runtime 的属性关联添加自定义 View
    private var customView : UIView? {
        get {
            return objc_getAssociatedObject(self, &SDStateBarViewKey) as? UIView
        }
        set(newVal) {
            objc_setAssociatedObject(self, &SDStateBarViewKey, newVal, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: 1.2、改变StateBar的颜色
    /// 改变StateBar的颜色
    /// - Parameter backgroundColor: StateBar的颜色
    func changeStateBarBackgroundColor(_ backgroundColor: UIColor) {
        if self.customView == nil {
            self.customView = UIView(frame: CGRect(x: 0, y: -kStatusBarFrameH, width: UIScreen.sd.width, height: kStatusBarFrameH))
            self.customView!.backgroundColor = UIColor.clear
            self.addSubview(self.customView!)
        }
        guard let weakCustomView = self.customView else {
            return
        }
        weakCustomView.backgroundColor = backgroundColor
    }
    
    // MARK: 1.3、去掉 StateBar 的颜色
    func resetBackgroundColor() {
        self.customView?.removeFromSuperview()
        self.customView = nil
    }
}


