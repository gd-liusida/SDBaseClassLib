//
//  UInt+Extension.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/4/3.
//

import UIKit

extension UInt: SDPOPCompatible {}

// MARK:- 一、UInt 与其他类型的转换
public extension SDPOP where Base == UInt {
    // MARK: 1.1、转 Int
    /// 转 Int
    var uintToInt: Int { return Int(self.base) }
}

