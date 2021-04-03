//
//  UISlider+Extension.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/4/3.
//

import Foundation
import UIKit

//MARK:- 一、基本的扩展
public extension SDPOP where Base: UISlider {
    
    // MARK: 1.1、UISlider的 闭包事件
    /// UISlider的 闭包事件
    /// - Parameters:
    ///   - controlEvents: 事件类型，默认是 valueChanged
    ///   - sliderCallBack: 闭包
    /// - Returns: 闭包内容
    func setHandle(controlEvents: UIControl.Event = .valueChanged, sliderCallBack: ((Float?) -> ())?) {
        base.swiftCallBack = sliderCallBack
        base.addTarget(base, action: #selector(base.sliderSwitchAction), for: controlEvents)
    }
}

private var sliderCallBackKey: Void?
extension UISlider: SDSwiftPropertyCompatible {
    internal typealias T = Float
    internal var swiftCallBack: SwiftCallBack? {
        get { return sd_getAssociatedObject(self, &sliderCallBackKey) }
        set { sd_setRetainedAssociatedObject(self, &sliderCallBackKey, newValue) }
    }
    
    @objc internal func sliderSwitchAction(_ event: UISlider) {
        self.swiftCallBack?(event.value)
    }
}

