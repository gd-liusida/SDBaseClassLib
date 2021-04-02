//
//  Bool+Extension.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/4/3.
//

import Foundation

extension Bool: SDPOPCompatible {}
// MARK:- 一、基本的扩展
public extension SDPOP where Base == Bool {
 
    // MARK: 1.1、Bool 值转 Int
    /// Bool 值转 Int
    var boolToInt: Int { return self.base ? 1 : 0 }
}

