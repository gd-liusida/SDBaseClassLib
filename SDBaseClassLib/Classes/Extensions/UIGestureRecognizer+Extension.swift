//
//  UIGestureRecognizer+Extension.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/4/3.
//

import Foundation

@objc extension UIGestureRecognizer {
    
    private struct AssociateKeys {
        static var funcName = "UIGestureRecognizer" + "funcName"
        static var closure = "UIGestureRecognizer" + "closure"
    }
    
    /// 方法名称(用于自定义)
    public var funcName: String {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.funcName) as? String {
                return obj
            }
 
            let string = String(describing: self.classForCoder);
            objc_setAssociatedObject(self, &AssociateKeys.funcName, string, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return string
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.funcName, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 闭包回调
    public func addAction(_ closure: @escaping (UIGestureRecognizer) -> Void) {
        objc_setAssociatedObject(self, &AssociateKeys.closure, closure, .OBJC_ASSOCIATION_COPY_NONATOMIC);
        addTarget(self, action: #selector(p_invoke))
    }
    
    private func p_invoke() {
        if let closure = objc_getAssociatedObject(self, &AssociateKeys.closure) as? ((UIGestureRecognizer) -> Void) {
            closure(self)
        }
    }
    
}

