//
//  UISwitch+Extension.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/4/3.
//

import Foundation
import UIKit

// MARK:- 一、基本的扩展
public extension SDPOP where Base: UISwitch {

    // MARK: 1.1、开关切换
    /// 开关切换
    func toggle() {
        self.base.setOn(!self.base.isOn, animated: true)
    }
    
    // MARK: 1.2、开关事件
    /// 开关事件
    /// - Parameters:
    ///   - controlEvents: 事件类型
    ///   - switchCallBack: 事件闭包
    /// - Returns: 闭包函数
    func setHandle(controlEvents: UIControl.Event = .touchUpInside, switchCallBack: ((_ isOn: Bool?) -> ())?){
        base.swiftCallBack = switchCallBack
        base.addTarget(base, action: #selector(base.swiftSwitchAction), for: controlEvents)
    }
}

private var switchCallBackKey: Void?
extension UISwitch: SDSwiftPropertyCompatible {
    internal typealias T = Bool
    internal var swiftCallBack: SwiftCallBack? {
        get { return sd_getAssociatedObject(self, &switchCallBackKey) }
        set { sd_setRetainedAssociatedObject(self, &switchCallBackKey, newValue) }
    }
    
    @objc internal func swiftSwitchAction(_ event: UISwitch) {
        self.swiftCallBack?(event.isOn)
    }
}

