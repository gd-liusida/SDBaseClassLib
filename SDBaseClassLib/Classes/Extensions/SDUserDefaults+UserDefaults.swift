//
//  SDUserDefaults+UserDefaults.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/3/23.
//  Copyright © 2021 奋斗青年. All rights reserved.
//

import Foundation

/// User default Key
public enum SDUserDefaultKey: String {
    /// 是否登录
    case isLogin           = "isLogin"
    /// 登录token
    case token             = "token"
    /// 唯一标识
    case deviceToken       = "deviceToken"
}

public extension UserDefaults {
    
    @discardableResult
    class func store<T>(key: SDUserDefaultKey, value: T) -> Bool {
        let standard = UserDefaults.standard
        standard.set(value, forKey: key.rawValue)
        return standard.synchronize()
    }
    
    @discardableResult
    class func read<T>(key: SDUserDefaultKey) -> T? {
        let standard = UserDefaults.standard
        let value = standard.value(forKey: key.rawValue)
        return value as? T
    }
    
    class func clear(_ keys: [SDUserDefaultKey]) {
        for key in keys {
            let standard = UserDefaults.standard
            standard.removeObject(forKey: key.rawValue)
        }
    }
    
}
